    //
    //  TodoListItemsViewModel.swift
    //  AdvanceConcepts
    //
    //  Created by mohit.dubey on 26/12/22.
    //

import SwiftUI
import CoreData

class TodoListItemsViewModel: ObservableObject {
//    let navigation: NavigationStack
//    
//    init(navigation: NavigationStack) {
//        self.navigation = navigation
//    }
    
    @Published var todoList: [TodoDetailViewModel] = []
    let vc = PersistenceController.shared.container.viewContext
    
    func getAllTodos() {
        DispatchQueue.global(qos: .background).async {[weak self] in
            let request = NSFetchRequest<TodoEntity>(entityName: "TodoEntity")
            if let todoEntityList = try? self?.vc.fetch(request), self?.todoList.count ?? 0 > 0 {
                DispatchQueue.main.async {[weak self] in
                    for item in todoEntityList {
                        self?.todoList.append(TodoDetailViewModel(item: item))
                    }
                }
            }
        }
    }
    
    func createNewTask() {
        
    }
}
