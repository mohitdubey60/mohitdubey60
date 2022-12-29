//
//  PopupView.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 29/12/22.
//

import SwiftUI

struct PopupView: View {
    @EnvironmentObject var coordinator: RootCoordinator
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PopupView_Previews: PreviewProvider {
    @State static var coordinator = RootCoordinator()

    static var previews: some View {
        PopupView()
            .environmentObject(coordinator)
    }
}
