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
            GoalHost()
                .font(.title)
                .tabItem {
                    VStack {
                        Image("goal")
                        Text("goals")
                    }
                }
                .tag(1)
            FormView(sessionStore: self._sessionStore, steps: String(self.sessionStore.session!.todaypoints.steps), waterfloz: String(self.sessionStore.session!.todaypoints.waterfloz), waste: self.sessionStore.session!.todaypoints.waste, CO2: self.sessionStore.session!.todaypoints.CO2, vegservings: self.sessionStore.session!.todaypoints.vegservings, meatservings: self.sessionStore.session!.todaypoints.meatservings, fruitservings: self.sessionStore.session!.todaypoints.fruitservings, dairyservings: self.sessionStore.session!.todaypoints.dairyservings, takeoutmeals: self.sessionStore.session!.todaypoints.takeoutmeals)
                .font(.title)
                .tabItem {
                    VStack {
                        Image("form")
                        Text("form")
                    }
                }
                .tag(2)
        }
    .onAppear(perform: {
        print(self.sessionStore.session!.todaypoints)
    })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//sessionStore: self._sessionStore, steps: String(self.sessionStore.session?.todaypoints.steps), waterfloz: String(self.sessionStore.session?.todaypoints.waterfloz), waste: (self.sessionStore.session?.todaypoints.steps)!, CO2: (self.sessionStore.session?.todaypoints.steps)!, vegservings: (self.sessionStore.session?.todaypoints.steps)!, meatservings: (self.sessionStore.session?.todaypoints.steps)!, fruitservings: (self.sessionStore.session?.todaypoints.steps)!, dairyservings: (self.sessionStore.session?.todaypoints.dairyservings)!, takeoutmeals: (self.sessionStore.session?.todaypoints.steps)!
