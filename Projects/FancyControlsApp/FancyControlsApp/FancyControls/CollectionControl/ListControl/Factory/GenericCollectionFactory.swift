//
//  GenericCollectionFactory.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 24/11/22.
//

import SwiftUI

protocol GenericCollectionFactory: AnyObject {
    associatedtype modelItem: CollectionItemModel
    associatedtype view: View
    
    func makeView(of item: modelItem) -> view
}
