//
//  PhotoModel.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 28/12/22.
//

import Foundation

struct PhotoModel: Codable, Identifiable {
    var albumID, id: Int?
    var title: String?
    var url, thumbnailURL: String?
    
    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
