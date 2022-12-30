//
//  CoordinatorListView.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 29/12/22.
//

import SwiftUI

struct CoordinatorListView: View {
    @EnvironmentObject var coordinator: RootCoordinator
    var body: some View {
        VStack {
            List(coordinator.items, id: \.self) { item in
                HStack {
                    Text(item)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .onTapGesture {
                    coordinator.gotoDetail(item)
                }
            }
            .foregroundColor(Color(uiColor: .systemMint))
            .listStyle(.plain)
            Spacer()
            if coordinator.isBackEnabled {
                Button {
                    coordinator.goBack()
                } label: {
                    Text("Go back")
                        .frame(minWidth: 150)
                        .foregroundColor(.white)
                        .padding()
                        .background(.red)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
            }
        }
        .navigationTitle("iPhone Lists")
    }
}

struct CoordinatorListView_Previews: PreviewProvider {
    @State static var coordinator = RootCoordinator()
    static var previews: some View {
        CoordinatorListView()
            .environmentObject(coordinator)
    }
}
