//
//  GreenButton.swift
//  temp
//
//  Created by Ria Bazaz on 5/2/20.
//  Copyright © 2020 Ria Bazaz. All rights reserved.
//

import SwiftUI

struct GreenButton: View {
 
    var body: some View {
        ZStack{
            
             RoundedRectangle(cornerRadius: 5)
               .fill(Color("green"))
               .frame(width: 400, height: 73)
               .opacity(0.75)
               .padding(.leading, 50)
            HStack(spacing: 120){
                Text("Tell us about today.")
                .font(.custom("OpenSans-Bold", size: 20))
                .foregroundColor(Color("fakewhite"))
                Image("expand")
                .resizable()
                .frame(width: 25, height: 25, alignment: .trailing)
            }
            .padding(.leading,50)
            

            
           
                

            

            
        }
        
    }
}

struct GreenButton_Previews: PreviewProvider {
    static var previews: some View {
        GreenButton()
    }
}
