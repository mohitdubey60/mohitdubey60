//
//  MockCommentModel.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 15/12/22.
//

import Foundation

struct MockCommentModel: Codable {
    let postID, id: Int
    let name, email, body: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
