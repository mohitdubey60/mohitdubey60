//
//  VideoListModel.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 10/05/23.
//

import Foundation

    // MARK: - Welcome
struct VideoListModel: Codable {
    let categories: [VideoListCategoryModel]
}

    // MARK: - Category
struct VideoListCategoryModel: Codable {
    let name: String
    let videos: [VideoItemModel]
}

    // MARK: - Video
struct VideoItemModel: Codable {
    let description: String
    let sources: [String]
    let subtitle: String
    let thumb, title: String
    let baseMediaUrl: String = "https://storage.googleapis.com/gtv-videos-bucket/sample/"
}
