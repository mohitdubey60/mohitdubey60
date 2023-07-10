//
//  ImageCacheRepo.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 11/05/23.
//

import Foundation

class ImageCacheRepo {
    private var repo: [String: Data] = [:]
    
    subscript(_ key: String) -> Data? {
        repo[key]
    }
    
    func add(key: String, value: Data) {
        repo[key] = value
    }
}

class ImageRepoFactory {
    static private var repo: [ImageCacheCategory: ImageCacheRepo] = [:]
    
    static func getRepo(for category: ImageCacheCategory) -> ImageCacheRepo {
        if let repoCategory = repo[category] {
            return repoCategory
        }
        
        let localRepo = ImageCacheRepo()
        repo[category] = localRepo
        return localRepo
    }
}
