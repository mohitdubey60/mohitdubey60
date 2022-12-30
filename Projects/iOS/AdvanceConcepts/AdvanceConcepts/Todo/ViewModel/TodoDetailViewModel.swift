//
//  TodoDetailViewModel.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 26/12/22.
//

import Foundation

class TodoDetailViewModel: ObservableObject, Identifiable {
    @Published var todoItem: TodoEntity
    let vc = PersistenceController.shared.container.viewContext
    
    init(item todoItem: TodoEntity) {
        self.todoItem = todoItem
    }
    
    func saveItem() {
        do {
            try vc.save()
        } catch let error {
            print("TodoDetailViewModel - Error in saving \(error.localizedDescription)")
        }
    }
}
