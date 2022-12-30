//
//  AdvanceConceptsApp.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 22/12/22.
//

import SwiftUI

@main
struct AdvanceConceptsApp: App {
    let persistenceController = PersistenceController.shared
    @State var coordinator = RootCoordinator()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            CoordinatorMainView()
                .environmentObject(coordinator)
        }
    }
}
