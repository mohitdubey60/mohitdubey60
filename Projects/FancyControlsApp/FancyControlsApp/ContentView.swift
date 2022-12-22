//
//  ContentView.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 12/11/22.
//

import SwiftUI

struct ContentView: View {
    let mock = ChatsMock()
    
    init() {
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                    //            SwiftUIControlsView(viewModel: SwiftUIControlsViewModel(urlString: "https://www.online-image-editor.com/styles/2019/images/power_girl.png"))
                
                    //            SwiftUIKitControlToSwiftUI().edgesIgnoringSafeArea(.all)
                
                
                    //                        VStack {
                    //                            GenericListView<ChatsCollectionViewModel, ChatsFactory>(viewModel: ChatsCollectionViewModel(listItems: mock.chats, groupedList: mock.groupedChats), factory: ChatsFactory())
                    //                        }
                    //                        .padding()
                
                
                    //            PhotosListView(viewModel: PhotosLibraryViewModel(manager: PhotosListManager()))
                
                    //        SpotifyAlbumDetailView()
                
                    //        ParallaxListView()
                
                    //        ContactsDetails()
                
//                TodoAppView()
//                PlanetCardStackUI()
                
//                CommentsTableView()
//                    .navigationTitle("Fade List items")
                
                InstagramCardView()
                    .navigationTitle("Instagram feed card")
                
//                BumbleListView()
//                    .navigationTitle("Bumble Card")
                
//                RatingsView()
//                    .navigationTitle("Rating + Haptic")
                
                
                Button("Send notification", action: {
                    LocalPushNotificationManager.shared.sendNotification(title: "My notification", subTitle: "My notification subtitle")
                })
                .buttonStyle(BorderedButtonStyle())
                .padding()
            }
            .navigationBarColor(backgroundColor: .systemBackground, titleColor: .label)
            .onAppear {
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
        }
    }
}

extension View {
    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
