//
//  EditGoalsView.swift
//  temp
//
//  Created by Ria Bazaz on 5/11/20.
//  Copyright © 2020 Ria Bazaz. All rights reserved.
//

import SwiftUI

struct EditGoalsView: View {

    var goals : [Goal]
    var body: some View {
        ZStack{
            Color("fakewhite")
             VStack {
                Text("Goals")
                .font(.custom("Montserrat-Regular", size: 40))

                            
             }
        }
        
    }
}

struct EditGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        let goals = [
            Goal(id: "hahahhaha", datecreated: "2020-06-04", goal: "Drink 60 oz of water a day for 1 month.", completed: false, goaltype: "water", waterfloz: 60, steps: 0, dayscompleted: 4, totalnumberofdays: 31, vegservings: 0, fruitservings: 0, meatservings: 0, dairyservings: 0, takeoutmeals: 0)
            
        ]
        return EditGoalsView(goals: goals)

    }
}
