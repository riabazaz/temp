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

struct User  {
    var points : [Point]
    var todaypoints : Point
    var completedgoals : [Goal]
    var progressgoals : [Goal]

}

struct Point : Codable {
    var date : String
    var overallpoints : Int
    var steps : Int
    var waterfloz : Int
    var waste : Int
    var CO2 : Int
    var vegservings : Int
    var fruitservings : Int
    var meatservings : Int
    var dairyservings : Int
    var takeoutmeals : Int
}

struct Goal : Codable {
    var id : String
    var datecreated : String
    var goal : String
    var completed : Bool
    var goaltype : String
    var waterfloz : Int
    var steps : Int
    var dayscompleted : Int
    var totalnumberofdays : Int
    var vegservings : Int
    var fruitservings : Int
    var meatservings : Int
    var dairyservings : Int
    var takeoutmeals : Int
}



class UserProfileRepository: ObservableObject {
  private var db = Firestore.firestore()
    
  func createProfile(profile: UserProfile, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
    
        let _ =  db.collection("profiles").document(profile.uid).setData([
            "uid" : profile.uid,
            "name" : profile.name,
            "email" : profile.email
        ])
      completion(profile, nil)
    
  }

    
  func fetchProfile(userId: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
    db.collection("profiles").document(userId).getDocument { (snapshot, error) in
     
        let map = snapshot?.data()
    
        let profile = UserProfile(uid: (map?["uid"] as! String?)!, name: (map?["name"] as! String?)!, email: (map?["email"] as! String?)!)
        completion(profile, error)
    }
    
  }
    

     
    
//    var date : Date
//    var overallpoints : Int
//    var steps : Int
//    var waterfloz : Int
//    var waste : Int
//    var CO2 : Int
    
    
    
    


    }
    
    


