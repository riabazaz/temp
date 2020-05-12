//
//  SessionStore.swift
//  temp
//
//  Created by Ria Bazaz on 5/3/20.
//  Copyright © 2020 Ria Bazaz. All rights reserved.
//

import Foundation
import Combine
import Firebase

class SessionStore: ObservableObject {
  @Published var session: User?
  @Published var profile: UserProfile?
  @Published var didChange = PassthroughSubject<SessionStore, Never>()
    { didSet { self.didChange.send(self) }}
  @Published var handle: AuthStateDidChangeListenerHandle?
    
  @Published var signedIn : Bool = false

  private var profileRepository = UserProfileRepository()
  private var db = Firestore.firestore()

    
    func listen ()  {
      // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("Got user: \(user)")
                self.profileRepository.fetchProfile(userId: user.uid) { (profile, error) in
                    if let error = error {
                      print("Error while fetching the user profile: \(error)")
                      return
                    }
                    self.profile = profile
                    self.getData() { (complete, error) in
                        if (complete != nil) {
                            self.session = complete
                            self.signedIn = true
                        }
                        
                    }

              }

            }
        }
  }

  func signUp(email: String, password: String, name: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
      if let error = error {
        print("Error signing up: \(error)")
        completion(nil, error)
        return
      }

      guard let user = result?.user else { return }
      print("User \(user.uid) signed up.")

        let userProfile = UserProfile(uid: user.uid, name: name, email : email)
        
      self.profileRepository.createProfile(profile: userProfile) { (profile, error) in
        if let error = error {
          print("Error while fetching the user profile: \(error)")
          completion(nil, error)
          return
        }
        self.profile = profile
        completion(profile, nil)
      }
    }
  }

  func signIn(email: String, password: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
      if let error = error {
        print("Error signing in: \(error)")
        completion(nil, error)
        return
      }

      guard let user = result?.user else { return }
      print("User \(user.uid) signed in.")

      self.profileRepository.fetchProfile(userId: user.uid) { (profile, error) in
        if let error = error {
          print("Error while fetching the user profile: \(error)")
          completion(nil, error)
          return
        }

        self.profile = profile
        self.getData() { (complete, error) in
            if (complete != nil) {
                self.signedIn = true
            }
        }
        completion(profile, nil)
      }
    }
  }

  func signOut() {
    do {
      try Auth.auth().signOut()
      self.session = nil
      self.profile = nil
    }
    catch let signOutError as NSError {
      print("Error signing out: \(signOutError)")
    }
  }
    func getData(completion: @escaping (_ user: User?, _ error: Error?) -> Void){
        
        fetchPoints(profile: self.profile!) { (point, points, error) in
            if error != nil {
                completion(nil, error)
            }
            let goals = [Goal]()
            let user = User(points: points!, todaypoints: point!, completedgoals: goals, progressgoals : goals)
            completion(user, nil)
        }
        
    }
   
    
    func writePoints(date: String, overallpoints: Int, steps: Int, waterfloz: Int, waste: Int, CO2: Int, vegservings: Int, meatservings: Int, fruitservings: Int, dairyservings: Int, takeoutmeals: Int, completion: @escaping (_ point: Point?, _ error: Error?) -> Void) {
        
        let point = Point(date: date, overallpoints: overallpoints, steps: steps, waterfloz: waterfloz, waste: waste, CO2: CO2,
      vegservings: vegservings, fruitservings: fruitservings, meatservings: meatservings, dairyservings: dairyservings, takeoutmeals: takeoutmeals)
        do {
            
            
            let _ =  db.collection("points").document(profile!.uid).collection(profile!.uid).document(date).setData([
                    "date" : date,
                    "overallpoints" : point.overallpoints,
                    "steps" : point.steps,
                    "waterfloz" : point.waterfloz,
                    "waste" : point.waste,
                    "CO2" : point.CO2,
                    "vegservings" : point.vegservings,
                    "meatservings" : point.meatservings,
                    "dairyservings" : point.dairyservings,
                    "fruitservings" : point.fruitservings,
                    "takeoutmeals" : point.takeoutmeals,
            ])
            completion(point, nil)
                
            }
    }
    
    
    func fetchPoints(profile : UserProfile, completion: @escaping (_ point: Point?, _ points: [Point]?, _ error: Error?) -> Void) {
        var points = [Point]()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        let newformatter = DateFormatter()
        newformatter.dateFormat = "MMM dd, yyyy"
        
        
        var today = Point(date: newformatter.string(from: Date()), overallpoints: 0, steps: 0,  waterfloz: 0,  waste: 0,
        CO2: 0, vegservings: 0, fruitservings: 0, meatservings: 0, dairyservings: 0,
        takeoutmeals : 0)
        
        
        db.collection("points").document(profile.uid).collection(profile.uid).getDocuments() { (snapshot, error) in
            for item in snapshot!.documents {
                let data = item.data()
                _ = data["date"] as! String
                let date : Date = (formatter.date(from: data["date"] as! String)!)
                let newdate = newformatter.string(from: date)
                let current = Point(date: newdate,
                                    overallpoints: data["overallpoints"] as! Int,
                 steps: data["steps"] as! Int,  waterfloz: data["waterfloz"] as! Int,  waste: data["waste"] as! Int,
                 CO2: data["CO2"] as! Int, vegservings: data["vegservings"] as! Int, fruitservings: data["fruitservings"] as! Int, meatservings: data["meatservings"] as! Int, dairyservings: data["dairyservings"] as! Int,
                 takeoutmeals : item["takeoutmeals"] as! Int)
                if(newdate == newformatter.string(from: Date())){
                    today = current
                    print(today)

                }
                points.append(current)
            }
        }
        completion (today, points, nil)


    }
    
    
    
}
