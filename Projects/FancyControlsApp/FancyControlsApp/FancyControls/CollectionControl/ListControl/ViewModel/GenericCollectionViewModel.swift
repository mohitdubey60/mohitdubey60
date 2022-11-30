//
//  GenericCollectionViewModel.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 24/11/22.
//

import Foundation

protocol GenericCollectionViewModel {
    associatedtype collectionItemType: CollectionItemModel
    
    var listItems: [collectionItemType] {get set}
    var groupedList: [String : [collectionItemType]] {get set}
    
    func removeItem(at offsets: IndexSet)
    func moveItem(from: IndexSet, to: Int)
}
