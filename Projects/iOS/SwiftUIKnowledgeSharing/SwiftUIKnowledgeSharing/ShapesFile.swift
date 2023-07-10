//
//  ShapesFile.swift
//  SwiftUIKnowledgeSharing
//
//  Created by mohit.dubey on 26/06/23.
//

import SwiftUI

struct ShapesFile: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.red)
                //            .stroke()
                .frame(height: 200)
                .shadow(color: .red.opacity(0.5), radius: 20, x: 20, y: 20)
                
            
            Capsule()
                .frame(height: 100)
        }
        .padding(20)
    }
}

struct ShapesFile_Previews: PreviewProvider {
    static var previews: some View {
        ShapesFile()
    }
}
