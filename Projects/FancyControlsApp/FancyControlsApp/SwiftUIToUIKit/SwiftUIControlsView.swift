//
//  SwiftUIControlsView.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 15/11/22.
//

import SwiftUI
//"https://www.online-image-editor.com/styles/2019/images/power_girl.png"
struct SwiftUIControlsView: View {
    var body: some View {
        VStack {
//            Image(uiImage: <#T##UIImage#>)
//                .frame(width: .infinity, height: 300)
//                .aspectRatio(1.77, contentMode: .fill)
//                .background(.red)
            AsyncImage(url: URL(string: "https://www.online-image-editor.com/styles/2019/images/power_girl.png")!) { image in
                image.image?.resizable()
                
            }
            .aspectRatio(1.77, contentMode: .fill)
            .frame(maxHeight: 300)
            Text("Network Image").font(.largeTitle)
            Text("This is a network image")
            Button("Download Image") {
                
            }
        }
    }
}

struct SwiftUIControlsView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIControlsView()
    }
}
