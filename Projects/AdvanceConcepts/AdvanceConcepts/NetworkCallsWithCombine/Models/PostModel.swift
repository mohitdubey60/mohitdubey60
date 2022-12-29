//
//  PostModel.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 26/12/22.
//

import Foundation

struct PostModel: Codable, Identifiable {
    var userID, id: Int?
    var title, body: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
