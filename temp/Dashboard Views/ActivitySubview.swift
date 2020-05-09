//
//  ActivitySubview.swift
//  temp
//
//  Created by Ria Bazaz on 5/7/20.
//  Copyright © 2020 Ria Bazaz. All rights reserved.
//

import SwiftUI

struct ActivitySubview: View {
    @EnvironmentObject var sessionStore : SessionStore

    var body: some View {
        VStack{
            CategoryButton(title: "ACTIVITY")
             Rectangle()
            .foregroundColor(Color("fakeblack"))
            .frame(width: 350, height: 1)
        }
        
    }
}

struct ActivitySubview_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySubview()
    }
}
