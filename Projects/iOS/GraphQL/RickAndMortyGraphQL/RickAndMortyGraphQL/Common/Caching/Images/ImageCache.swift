//
//  ImageCache.swift
//  RickAndMortyGraphQL
//
//  Created by mohit.dubey on 18/01/23.
//

import Foundation

class ImageCache {
    static let shared: ImageCache = ImageCache()
    
    private init() {}
    @atomic private(set) var cache: [String : Data] = [:]
    
    func setImage(data: Data, for url: String) {
        cache[url] = data
    }
    
    func clearAllCache() {
        cache = [:]
    }
}
