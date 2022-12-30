    //
    //  CoordinatorMainView.swift
    //  AdvanceConcepts
    //
    //  Created by mohit.dubey on 29/12/22.
    //

import SwiftUI

struct CoordinatorMainView: View {
    @EnvironmentObject var coordinator: RootCoordinator
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.getPage(.home)
                .navigationTitle("iPhone Home Page")
                .sheet(item: $coordinator.sheet) {sheet in
                    coordinator.getSheet(sheet)
                }
                .navigationDestination(for: AllPages.self) { page in
                    coordinator.getPage(page)
                }
                .onOpenURL { url in
                    print("Clicked on url")
                }
        }
    }
}

struct CoordinatorMainView_Previews: PreviewProvider {
    @State static var coordinator = RootCoordinator()
    static var previews: some View {
        CoordinatorMainView()
            .environmentObject(coordinator)
    }
}
