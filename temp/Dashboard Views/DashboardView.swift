//
//  Dashboard.swift
//  temp
//
//  Created by Ria Bazaz on 5/2/20.
//  Copyright © 2020 Ria Bazaz. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
 
    var body: some View {
        ZStack{
            Color("fakewhite")
            VStack(spacing: 5){
                GreetingPoints(points: 420696, name: "Ria")
                GreenButton()
                .padding(.bottom, 30)
                
            }

            
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
