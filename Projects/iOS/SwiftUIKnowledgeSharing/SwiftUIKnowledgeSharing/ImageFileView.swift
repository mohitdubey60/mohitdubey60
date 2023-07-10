//
//  ImageFileView.swift
//  SwiftUIKnowledgeSharing
//
//  Created by mohit.dubey on 26/06/23.
//

import SwiftUI

struct ImageFileView: View {
    var body: some View {
        Image("splashLogo101")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 300)
            .clipped()
            .background(.red)
    }
}

struct ImageFileView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFileView()
    }
}
