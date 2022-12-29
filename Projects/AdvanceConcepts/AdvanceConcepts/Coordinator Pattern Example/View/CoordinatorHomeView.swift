//
//  CoordinatorHomeView.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 29/12/22.
//

import SwiftUI

struct CoordinatorHomeView: View {
    @EnvironmentObject var coordinator: RootCoordinator
    var body: some View {
        VStack {
            Spacer()
            Button {
                coordinator.gotoDetail(coordinator.items.first!)
            } label: {
                Text("Move to Details")
                    .frame(minWidth: 150)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(uiColor: .systemMint))
                    .cornerRadius(10)
            }

            Button {
                coordinator.gotoList()
            } label: {
                Text("Move to List")
                    .frame(minWidth: 150)
                    .foregroundColor(.white)
                    .padding()
                    .background(.orange)
                    .cornerRadius(10)
            }
            
            Button {
                coordinator.openSheet()
            } label: {
                Text("Open sheet")
                    .frame(minWidth: 150)
                    .foregroundColor(.white)
                    .padding()
                    .background(.purple)
                    .cornerRadius(10)
            }
            
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
        .shadow(radius: 10)
    }
}

struct CoordinatorHomeView_Previews: PreviewProvider {
    @State static var coordinator = RootCoordinator()

    static var previews: some View {
        CoordinatorHomeView()
            .environmentObject(coordinator)
    }
}
