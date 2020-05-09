//
//  Sign.swift
//  temp
//
//  Created by Ria Bazaz on 5/3/20.
//  Copyright © 2020 Ria Bazaz. All rights reserved.
//

import SwiftUI

struct SignView: View {
  @State var name: String = ""
  @State var email: String = ""
  @State var password: String = ""
  @State var confirmPassword: String = ""

  @State var showSignUpForm = true
  @State var signedIn = false

  @EnvironmentObject var sessionStore : SessionStore
  @State var profile: UserProfile?

  var body: some View {
    NavigationView{
                  VStack {
                    if self.showSignUpForm {
                      Form {
                        Section {
                          TextField("Name", text: $name)
                            .textContentType(.givenName)
                        }
                        Section {
                          TextField("Email", text: $email)
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                          SecureField("Password", text: $password)
                          SecureField("Confirm password", text: $confirmPassword)
                        }
                        NavigationLink(destination: ContentView(), isActive : $signedIn) {
                            Button(action: { self.signUp() }) {
                              Text("Sign up")
                            }
                        }
                        
                      }
                      .navigationBarTitle("Sign up")
                    }
                    else {
                      Form {
                        TextField("Email", text: $email)
                          .textContentType(.emailAddress)
                          .autocapitalization(.none)
                        SecureField("Password", text: $password)
                        NavigationLink(destination: ContentView(), isActive : $signedIn) {
                            Button(action: { self.signIn() }) {
                              Text("Sign in")
                            }
                        }
                      }
                      .navigationBarTitle("Sign up")

                    }
                    Button(action: { self.showSignUpForm.toggle() }) {
                      Text(self.showSignUpForm ? "Have an account? Sign in instead." : "No account yet? Click here to sign up instead.")
                    }
                  }
    }
      
    
  }

  func signUp() {
        sessionStore.signUp(email: self.email, password: self.password, name: self.name) { (profile, error) in
          if let error = error {
            print("Error when signing up: \(error)")
            return
          }
          self.profile = profile
          self.signedIn = true
      }
     }

  func signIn() {
    sessionStore.signIn(email: self.email, password: self.password) { (profile, error) in
      if let error = error {
        print("Error when signing up: \(error)")
        return
      }
      self.profile = profile
      self.signedIn = true
    }
  }
}

struct SignView_Previews: PreviewProvider {
  static var previews: some View {
    SignView()
  }
}
