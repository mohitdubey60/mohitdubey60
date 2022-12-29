//
//  FetchRequest_TodoListView.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 23/12/22.
//

import SwiftUI

struct FetchRequest_TodoListView: View {
    @ObservedObject var vm = TodoListItemsViewModel()
    
    var body: some View {
        VStack {
            if vm.todoList.count > 0 {
                let _ = print("TotalCount is \(vm.todoList.count)")
                List(vm.todoList) { todoItem in
                    Text("")
                }
                .listStyle(.plain)
            } else {
                VStack(spacing: 8) {
                    Image(systemName: "note.text.badge.plus")
                        .font(.system(size: 52))
                    Text("No Todo Item found")
                        .font(.system(size: 20))
//                    NavigationLink(destination: FetchRequest_TodoDetailsView(vm: TodoDetailViewModel(item: nil))) {
                        Text("Tap to create")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .padding()
                            .padding(.horizontal)
                            .background(.tint)
                            .cornerRadius(10)
                            .padding(.top)
                            .shadow(color: Color(uiColor: .label), radius: 4)
//                    }
                }
                .foregroundColor(.secondary)
                .padding()
                .background(Color(uiColor: .systemBackground))
                .cornerRadius(10)
                .shadow(color: Color(uiColor: .label), radius: 10)
            }
                
        }
        .onAppear {
            vm.getAllTodos()
        }
        .navigationTitle("Todo List")
        .navigationBarItems(leading: Button {
            
        } label: {
                //                Label("Add Item", systemImage: "plus")
        }, trailing: Button {
            
        } label: {
//            NavigationLink(destination: FetchRequest_TodoDetailsView(vm: TodoDetailViewModel(item: TodoEntity(context: PersistenceController.shared.container.viewContext)))) {
                Label("Add Item", systemImage: "plus")
                    .labelStyle(TitleAndIconLabelStyle())
//            }
        })
    }
}

struct FetchRequest_TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        FetchRequest_TodoListView()
    }
}
