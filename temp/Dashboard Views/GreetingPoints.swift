//
//  GreetingPoints.swift
//  temp
//
//  Created by Ria Bazaz on 5/2/20.
//  Copyright © 2020 Ria Bazaz. All rights reserved.
//

import SwiftUI

struct GreetingPoints: View {
    var points : Int
    var name : String
    
    var body: some View {
         VStack(spacing: 5){
             VStack{
                 Image("logo")
                 .resizable()
                 .frame(width: 50, height: 50, alignment: .trailing)
                 Text("420,696")                 //imported
                 .font(.custom("OpenSans-Light", size: 16))
                 .foregroundColor(Color("fakeblack"))
             }
             .padding(.leading, 300)
             .padding(.bottom, -60)

             VStack (alignment: .leading, spacing: -10){
                 Text("HELLO,")
                 .font(.custom("OpenSans-Light", size: 65))
                Text(name.uppercased() + ".")
                 .font(.custom("Montserrat-Bold", size: 80))
             }
             .foregroundColor(Color("fakeblack"))
             .padding(.trailing,100)
             .padding(.bottom)
            
            
            

        }
    }
        
}

struct GreetingPoints_Previews: PreviewProvider {
    static var previews: some View {
        GreetingPoints(points: 69, name: "Ria")
    }
}
