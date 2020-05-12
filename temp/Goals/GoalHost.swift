//
//  GoalHost.swift
//  temp
//
//  Created by Ria Bazaz on 5/11/20.
//  Copyright © 2020 Ria Bazaz. All rights reserved.
//

import SwiftUI

struct GoalHost: View {
    @Environment(\.editMode) var mode
    @EnvironmentObject var sessionStore : SessionStore
    
    var body: some View {
        
        VStack{
                HStack {
                    if self.mode?.wrappedValue == .active {
                        Button(action:{
                            self.mode?.animation().wrappedValue = .inactive
                        }){
                            Image("delete")
                            .font(.custom("Montserrat-Regular", size: 20))
                            .padding(.leading,20)

                        }
                    }
                    
                    Spacer()
                    
                    if self.mode?.wrappedValue == .inactive {
                        Button(action:{
                            self.mode?.animation().wrappedValue = .active
                        }){
                            Text("Select")
                            .font(.custom("Montserrat-Regular", size: 20))
                            .padding(.trailing,20)

                        }
                    }
                    else{
                        Button(action:{
                            self.mode?.animation().wrappedValue = .inactive
                        }){
                            Text("Done")
                            .font(.custom("Montserrat-Regular", size: 20))
                            .padding(.trailing,20)

                        }
                    }
//r
                }
                if self.mode?.wrappedValue == .inactive {
                    GoalView(progressgoals : self.sessionStore.session!.progressgoals, completedgoals: self.sessionStore.session!.completedgoals)
                }
//                else {
////                    EditGoalsView()
////                    .onDisappear {
//////                            self.userData.profile = self.draftProfile
////                        self.mode?.animation().wrappedValue = .inactive
////                    }
//                }
            }
        }
    
    
    
}

struct GoalHost_Previews: PreviewProvider {
    static var previews: some View {
        GoalHost()
        .environmentObject(SessionStore())

    }
}
