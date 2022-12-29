//
//  CoordinatorDetailView.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 29/12/22.
//

import SwiftUI

struct CoordinatorDetailView: View {
    var product: String
    @EnvironmentObject var coordinator: RootCoordinator
    
    init(product: String) {
        self.product = product
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(product)
                .font(.system(size: 30))
            Button {
                coordinator.gotoList()
            } label: {
                Text("Go to List")
                    .frame(minWidth: 150)
                    .foregroundColor(.white)
                    .padding()
                    .background(.orange)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            Button {
                coordinator.openSheet()
            } label: {
                Text("Open Sheet")
                    .frame(minWidth: 150)
                    .foregroundColor(.white)
                    .padding()
                    .background(.purple)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            
            Button {
                coordinator.gotoHome()
            } label: {
                Text("Go to Home")
                    .frame(minWidth: 150)
                    .foregroundColor(.white)
                    .padding()
                    .background(.tint)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            
            Spacer()
            if coordinator.path.count > -1 {
                HStack {
                    Button {
                        coordinator.eraseToHome()
                    } label: {
                        Text("Erase to Home")
                            .frame(minWidth: 100)
                            .foregroundColor(.white)
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    Button {
                        coordinator.goBack()
                    } label: {
                        Text("Go back")
                            .frame(minWidth: 100)
                            .foregroundColor(.white)
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                }
            }
        }
        .navigationTitle(product)
    }
}

struct CoordinatorDetailView_Previews: PreviewProvider {
    @State static var coordinator = RootCoordinator()

    static var previews: some View {
        CoordinatorDetailView(product: coordinator.items.first!)
            .environmentObject(coordinator)
    }
}
