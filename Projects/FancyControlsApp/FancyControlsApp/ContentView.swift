//
//  ContentView.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 12/11/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
//            SwiftUIControlsView(viewModel: SwiftUIControlsViewModel(urlString: "https://www.online-image-editor.com/styles/2019/images/power_girl.png"))
            SwiftUIKitControlToSwiftUI().edgesIgnoringSafeArea(.all)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
