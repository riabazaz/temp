//
//  DashboardGoals.swift
//  temp
//
//  Created by Ria Bazaz on 5/2/20.
//  Copyright © 2020 Ria Bazaz. All rights reserved.
//

import SwiftUI

struct DashboardGoals: View {
    var points : Int
    var name : String
    
    var body: some View {
         VStack{
            CategoryButton(title: "GOALS")
//            ScrollView(.horizontal){
                
//            }
            
            

        }
    }
        
}

struct DashboardGoals_Previews: PreviewProvider {
    static var previews: some View {
        DashboardGoals(points: 69, name: "Ria")
    }
}
