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
    
    func listen () {
      // monitor authentication changes using firebase
      handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        guard let user = user else { return }
        print("User \(user.uid) signed in.")
        self.signedIn = true
        print("listened")
        print(self.signedIn)
        
        self.profileRepository.fetchProfile(userId: user.uid) { (profile, error) in
            if let error = error {
              print("Error while fetching the user profile: \(error)")
              return
            }
            self.profile = profile
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
   
    func writePoints(date: Date, overallpoints: Int, steps: Int, waterfloz: Int, waste: Int, CO2: Int, vegservings: Int, meatservings: Int, fruitservings: Int, dairyservings: Int, takeoutmeals: Int, completion: @escaping (_ point: Point?, _ error: Error?) -> Void) {
        
        let food = FoodServings(vegservings: vegservings, fruitservings: fruitservings, meatservings: meatservings, dairyservings: dairyservings, takeoutmeals: takeoutmeals)
        
        let point = Point(date: date, overallpoints: overallpoints, steps: steps, waterfloz: waterfloz, waste: waste, CO2: CO2, food: food)
        self.profileRepository.createPoints(profile: self.profile!, point: point) { (point, error) in
          if let error = error {
            print("Error while writing the user point: \(error)")
            completion(nil, error)
            return
          }
            
          completion(point, nil)
        }
        if(point.date == Date()){
            self.session?.todaypoints = point
        }
        
    }
}
