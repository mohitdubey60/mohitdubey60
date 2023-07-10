//
//  StartView.swift
//  SwiftUIKnowledgeSharing
//
//  Created by mohit.dubey on 26/06/23.
//

import SwiftUI

struct StartView: View {
    
    var body: some View {
        VStack {
            Text("Hello, World! Hello, World! Hello, World!Hello, World! Hello, World!")
                .font(.system(size: 50))
                .bold()
                .minimumScaleFactor(0.1)
                //            .frame(maxWidth: .infinity, alignment: .bottom)
                //            .background(.green)
                .frame(width:100, height: 100)
                .background(.red)
            
            Button {
                
            } label: {
                Text("My Button")
                    .font(.system(size: 32))
            }

        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
