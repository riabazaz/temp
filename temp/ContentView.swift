//
//  ContentView.swift
//  temp
//
//  Created by Ria Bazaz on 5/2/20.
//  Copyright © 2020 Ria Bazaz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    @EnvironmentObject var sessionStore : SessionStore

    var body: some View {
        TabView(){
            DashboardView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image("home")
                        Text("home")
                    }
                }
                .tag(0)
            FormView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image("form")
                        Text("form")
                    }
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
