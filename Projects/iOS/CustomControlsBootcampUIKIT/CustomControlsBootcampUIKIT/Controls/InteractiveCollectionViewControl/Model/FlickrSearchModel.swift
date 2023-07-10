//
//  FlickrSearchModel.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 08/06/23.
//

import Foundation

    // MARK: - FlickrSearchModel
struct FlickrSearchParentModel: Codable {
    let photos: FlickrSearchPhotosList
    let stat: String
}

    // MARK: - Photos
struct FlickrSearchPhotosList: Codable {
    let page, pages, perpage, total: Int
    let photo: [FlickrSearchPhoto]
}

    // MARK: - Photo
struct FlickrSearchPhoto: Codable, Hashable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    
    var photoUrl: String {
        "https://live.staticflickr.com/\(server)/\(id)_\(secret)_w.jpg"
    }
}
