//
//  GenericListView.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 24/11/22.
//

import SwiftUI

struct GenericListView<T: GenericCollectionViewModel & ObservableObject, F: GenericCollectionFactory>: View {
    @ObservedObject var viewModel: T
    let factory: F
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach( searchText.isEmpty ? viewModel.listItems :
                        viewModel.listItems.filter({ item in
                        item.title.contains(searchText)
                    }), id: \.id) { item in
                        factory.makeView(of: item as! F.modelItem)
                    }
                    .onDelete { indexSet in
                        delete(at: indexSet)
                    }
                    .onMove { from, to in
                        move(from: from, at: to)
                    }
                }
                .listStyle(.plain)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "rectangle.stack")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search for Chats")
            .searchSuggestions {
                ForEach(viewModel.listItems, id: \.id) { item in
                    Text(item.title).searchCompletion(item.title)
                }
            }
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .padding(0)
    }
    
    func delete(at Offsets: IndexSet) {
        viewModel.removeItem(at: Offsets)
    }
    
    func move(from initalIndex: IndexSet, at finalIndex: Int) {
        viewModel.moveItem(from: initalIndex, to: finalIndex)
    }
}

struct GenericListView_Previews: PreviewProvider {
    
    static var previews: some View {
        let mock = ChatsMock()
        GenericListView<ChatsCollectionViewModel, ChatsFactory>(viewModel: ChatsCollectionViewModel(listItems: mock.chats, groupedList: mock.groupedChats), factory: ChatsFactory())
    }
}
