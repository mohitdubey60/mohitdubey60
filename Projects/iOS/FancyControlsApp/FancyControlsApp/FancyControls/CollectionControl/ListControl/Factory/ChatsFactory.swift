//
//  ChatsFactory.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 24/11/22.
//

import SwiftUI

class ChatsFactory: GenericCollectionFactory {
    typealias view = AnyView
    typealias modelItem = Chat
    
    func makeView(of item: modelItem) -> view {
        switch item.type {
            case .user:
                return AnyView(UserChatCellView(item: item))
            case .group:
                return AnyView(GroupChatCellView(item: item))
        }
    }
}
