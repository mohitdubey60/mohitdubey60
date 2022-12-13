//
//  TodoAppUser.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 12/12/22.
//

import Foundation

struct TodoAppUser: Codable, Hashable {
    var name: String
    var age: Int
}

typealias TodoAppUserList = [TodoAppUser]

extension TodoAppUserList: RawRepresentable, Hashable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(TodoAppUserList.self, from: data)
        else {
            return nil
        }
        self = result
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
