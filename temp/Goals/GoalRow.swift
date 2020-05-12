//
//  GoalRow.swift
//  temp
//
//  Created by Ria Bazaz on 5/11/20.
//  Copyright © 2020 Ria Bazaz. All rights reserved.
//

import SwiftUI

struct GoalRow: View {
    var goal : Goal
    var body: some View {
        ZStack(alignment: .leading){
            Color("fakewhite")
            Rectangle()
            .fill(Color("fakewhite"))
            .frame(width: 350, height: 110)
                .border(Color("darkestblue"),width: 0.7)
            Rectangle()
            .fill(Color("darkestblue").opacity(getFrac()))
            .frame(width: getOverlayRectSize(), height: 110)
//            Image(getImage())
            HStack{
                if self.goal.goaltype == "water" {
                    Image("water")
                }
                else if self.goal.goaltype == "steps" {
                    Image("walking")
                }
                else if self.goal.goaltype == "waste" {
                    Image("waste")

                }
                else {
                    Image("walking")
                }
                Text(self.goal.goal)
                    .font(.custom("OpenSans-Regular", size: 18))
                    .frame(maxWidth: 255)
//                .foregroundColor(getTextColor())

            }
            .padding(.leading, 15)


        }.padding(.leading, 30)
    }
    
    
    func getOverlayRectSize() -> CGFloat {
        
        let frac : Double = Double(Double(goal.dayscompleted)/Double(goal.totalnumberofdays))
        
        return CGFloat(frac * 350)
    }
    
    func getFrac() -> Double {
         let frac : Double = Double(Double(goal.dayscompleted)/Double(goal.totalnumberofdays))
        return frac
    }
    
    func getTextColor() -> Color {
        if(getFrac() > 0.6 ){
            return Color("fakewhite")
        }
        return Color("fakeblack")
    }
    
    
}


struct GoalRow_Previews: PreviewProvider {
    static var previews: some View {
        GoalRow(goal: Goal(id: "hahahhaha",datecreated: "2020-06-04", goal: "Drink 60 oz of water a day for 1 month.",  completed: false, goaltype: "water", waterfloz: 60, steps: 0, dayscompleted: 4, totalnumberofdays: 31, vegservings: 0, fruitservings: 0, meatservings: 0, dairyservings: 0, takeoutmeals: 0))
    }
}
