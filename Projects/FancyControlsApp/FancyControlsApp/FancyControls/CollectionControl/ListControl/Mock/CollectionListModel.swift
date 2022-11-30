//
//  CollectionListModel.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 23/11/22.
//

import Foundation

enum ChatEntityType: String {
    case user
    case group
}

protocol CollectionItemModel {
    var id: String {get set}
    var title: String {get set}
}

class Chat: CollectionItemModel {
    var id: String
    var title: String
    var imagePath: String
    var description: String
    let type: ChatEntityType
    
    init(id: String, name: String, imagePath: String, description: String, type: ChatEntityType) {
        self.id = id
        self.title = name
        self.imagePath = imagePath
        self.description = description
        self.type = type
    }
}

class ChatGroup: Chat {
    var membersCount: Int
    
    init(id: String, name: String, imagePath: String, description: String,
         type: ChatEntityType, membersCount: Int) {
        self.membersCount = membersCount
        super.init(id: id, name: name, imagePath: imagePath,
                   description: description, type: type)
    }
}

class ChatsMock {
    var chats: [Chat] = [Chat(id: UUID().uuidString, name: "Mohit Dubey",
                              imagePath: "https://images.unsplash.com/photo-1618042164219-62c820f10723?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZG93bmxvYWR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60", description: "Kache kandho par papa ne lada pending sapno ka bojh", type: .user),
                         Chat(id: UUID().uuidString, name: "Garima Tripathi",
                              imagePath: "https://images.unsplash.com/photo-1549287748-f095932c9f81?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=654&q=80", description: "Mein apni favorite hu",
                              type: .user),
                         ChatGroup(id: UUID().uuidString, name: "Family", imagePath: "https://images.unsplash.com/photo-1503249023995-51b0f3778ccf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGRvd25sb2FkfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60", description: "Hum sath sath hai", type: .group, membersCount: 12),
                         ChatGroup(id: UUID().uuidString, name: "Office", imagePath: "https://images.unsplash.com/photo-1554266183-2696fdafe3ff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fGRvd25sb2FkfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60", description: "Work, Work, Work!", type: .group, membersCount: 20)]
    var groupedChats: [String : [Chat]] {
        get {
            Dictionary(grouping: chats, by: { $0.type.rawValue } )
        }
    }
}
