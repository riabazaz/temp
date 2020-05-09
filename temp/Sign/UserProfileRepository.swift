//
//  UserProfileRepository.swift
//  temp
//
//  Created by Ria Bazaz on 5/3/20.
//  Copyright © 2020 Ria Bazaz. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

struct UserProfile: Codable {
  var uid: String
  var name: String
  var email : String
}

struct User : Codable {
    var points : [Point]
    var todaypoints : Point
}

struct Point : Codable {
    var date : Date
    var overallpoints : Int
    var steps : Int
    var waterfloz : Int
    var waste : Int
    var CO2 : Int
    var food : FoodServings
}

struct Goal : Codable {
    var completed : Bool
    var goaltype : String
    var waterfloz : Int
    var steps : Int
    var food : FoodServings
    var dayscompleted : Int
    var totalnumberofdays : Int
}

struct FoodServings : Codable {
    var vegservings : Int
    var fruitservings : Int
    var meatservings : Int
    var dairyservings : Int
    var takeoutmeals : Int
}

class UserProfileRepository: ObservableObject {
  private var db = Firestore.firestore()

  func createProfile(profile: UserProfile, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
    do {
        let _ = try db.collection("profiles").document(profile.uid).setData([
            "uid" : profile.uid,
            "name" : profile.name,
            "email" : profile.email
        ])
        
      completion(profile, nil)
    }
    catch let error {
      print("Error writing user to Firestore: \(error)")
      completion(nil, error)
    }
  }

  func fetchProfile(userId: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
    db.collection("profiles").document(userId).getDocument { (snapshot, error) in
     
        let map = try? snapshot?.data()
        let profile = try? UserProfile(uid: (map?["uid"] as! String?)!, name: (map?["name"] as! String?)!, email: (map?["email"] as! String?)!)
        
        completion(profile, error)
    }
  }
    
//    var date : Date
//    var overallpoints : Int
//    var steps : Int
//    var waterfloz : Int
//    var waste : Int
//    var CO2 : Int
    
    func createPoints(profile : UserProfile, point: Point, completion: @escaping (_ points: Point?, _ error: Error?) -> Void) {
        do {
            let formatter1 = DateFormatter()
            formatter1.dateStyle = .medium
            let dbdate = formatter1.string(from: point.date)
            print(dbdate)
            
            let _ = try db.collection("points").document(profile.uid).collection(dbdate).addDocument(data: [
                "date" : dbdate,
                "overallpoints" : point.overallpoints,
                "steps" : point.steps,
                "waterfloz" : point.waterfloz,
                "waste" : point.waste,
                "CO2" : point.CO2,
                "food" : point.food
            ])
            
          completion(point, nil)
            
        }
        catch let error {
          print("Error writing user to Firestore: \(error)")
          completion(nil, error)
    }
    }
    
    
//    func fetchPoints(profile : UserProfile, completion: @escaping (_ points: [Point]?, _ error: Error?) -> Void) {
//        db.collection("points").document(profile.uid).getDocument { (snapshot, error) in
//            var points = [Point]()
//            for item in snapshot!.documents! {
//                let point = try? UserProfile(uid: (item["date"] as! String?)!, name: (item["name"] as! String?)!, email: (item["email"] as! String?)!)
//            }
//            
//            completion(points, error)
//        }
//        
//    }

}

