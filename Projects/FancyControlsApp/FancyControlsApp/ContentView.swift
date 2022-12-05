//
//  ContentView.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 12/11/22.
//

import SwiftUI

struct ContentView: View {
    let mock = ChatsMock()
    var body: some View {
//            SwiftUIControlsView(viewModel: SwiftUIControlsViewModel(urlString: "https://www.online-image-editor.com/styles/2019/images/power_girl.png"))
            
//            SwiftUIKitControlToSwiftUI().edgesIgnoringSafeArea(.all)


//                        VStack {
//                            GenericListView<ChatsCollectionViewModel, ChatsFactory>(viewModel: ChatsCollectionViewModel(listItems: mock.chats, groupedList: mock.groupedChats), factory: ChatsFactory())
//                        }
//                        .padding()
            
            
            PhotosListView(viewModel: PhotosLibraryViewModel(manager: PhotosListManager()))
        
//        SpotifyAlbumDetailView()
        
//        ParallaxListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
