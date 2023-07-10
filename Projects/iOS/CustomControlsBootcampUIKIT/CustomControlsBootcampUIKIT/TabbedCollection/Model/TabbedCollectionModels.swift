//
//  File.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 09/05/23.
//

import Foundation

protocol TabbedCollectionItem {
    var page: TabbedCollectionHeader { get }
    var body: TabbedCollectionPage { get }
}

protocol TabbedCollectionHeader {
    var page: String { get }
}

protocol TabbedCollectionPage {
    
}
