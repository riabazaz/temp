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

}
