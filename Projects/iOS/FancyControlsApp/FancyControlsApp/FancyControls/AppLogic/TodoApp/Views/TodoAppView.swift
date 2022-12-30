//
//  TodoAppView.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 12/12/22.
//

import SwiftUI

struct TodoAppView: View {
    @AppStorage("userList") var userList: TodoAppUserList = []
    
    var body: some View {
        VStack {
            if userList.count == 0 {
                WelcomeView()
            } else {
                TodoAppUserListView()
            }
        }
        .background {
            RadialGradient(colors: [Color.purple, Color.blue], center: .topLeading, startRadius: 100, endRadius: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct TodoAppView_Previews: PreviewProvider {
    static var previews: some View {
        TodoAppView()
    }
}
