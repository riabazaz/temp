//
//  CategoryButton.swift
//  temp
//
//  Created by Ria Bazaz on 5/2/20.
//  Copyright © 2020 Ria Bazaz. All rights reserved.
//

import SwiftUI

struct CategoryButton: View {
    var title : String
    var body: some View {
        ZStack{
             RoundedRectangle(cornerRadius: 5)
               .fill(Color("lightblue"))
                .frame(width: 120, height: 30)
               .opacity(0.5)
            Text(title)
            .font(.custom("Montserrat-Regular", size: 22))


        }
        
    }
}

struct CategoryButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButton(title: "Activity")
    }
}
