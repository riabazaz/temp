//
//  GoalView.swift
//  temp
//
//  Created by Ria Bazaz on 5/11/20.
//  Copyright © 2020 Ria Bazaz. All rights reserved.
//
import SwiftUI

struct GoalView: View {
    var progressgoals : [Goal]
    var completedgoals : [Goal]
    
    var body: some View {
        ZStack{
            Color("fakewhite")
             VStack {
                
                Text("Goals")
                .font(.custom("Montserrat-Regular", size: 40))
                GoalRow(goal: Goal(id: "hahahhaha", datecreated: "2020-06-04", goal: "Drink 60 oz of water a day for 1 month.",  completed: false, goaltype: "water", waterfloz: 60, steps: 0, dayscompleted: 4, totalnumberofdays: 31, vegservings: 0, fruitservings: 0, meatservings: 0, dairyservings: 0, takeoutmeals: 0))
             }
        }
        
    }
}

// ! Note !
// push data in firebase in order of date created
// read in order of creation data from firebase in order of creation
// separate between progress/completed after reading from firebase

//within row:

// determine what type of goal
// get corresponding icon

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        let goals = [
            Goal(id: "hahahhaha", datecreated: "2020-06-04", goal: "Drink 60 oz of water a day for 1 month.", completed: false, goaltype: "water", waterfloz: 60, steps: 0, dayscompleted: 4, totalnumberofdays: 31, vegservings: 0, fruitservings: 0, meatservings: 0, dairyservings: 0, takeoutmeals: 0)
            
        ]
        return GoalView(progressgoals: goals, completedgoals: goals)
        

    }
}
