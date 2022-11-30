//
//  ChatsCollectionViewModel.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 24/11/22.
//

import Foundation

class ChatsCollectionViewModel: GenericCollectionViewModel, ObservableObject {
    typealias collectionItemType = Chat
    
    @Published var listItems: [Chat]
    var groupedList: [String : [Chat]]
    
    init(listItems: [Chat], groupedList: [String : [Chat]]) {
        self.listItems = listItems
        self.groupedList = groupedList
    }
    
    func removeItem(at offsets: IndexSet) {
        listItems.remove(atOffsets: offsets)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        listItems.move(fromOffsets: from, toOffset: to)
    }
}
