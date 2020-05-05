//
//  RootView.swift
//  temp
//
//  Created by Ria Bazaz on 5/5/20.
//  Copyright © 2020 Ria Bazaz. All rights reserved.
//

import SwiftUI

struct RootView: View {

    @EnvironmentObject var sessionStore : SessionStore
    var body: some View {
         VStack {
            Text("hi")
            if self.sessionStore.signedIn {
                ContentView()
            }
            else {
                SignView()
            }
                        
        }
        
    }
}
