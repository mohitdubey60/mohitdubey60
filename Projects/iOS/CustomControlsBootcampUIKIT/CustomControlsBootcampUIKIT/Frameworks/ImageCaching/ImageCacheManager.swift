//
//  ImageCacheManager.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 11/05/23.
//

import Foundation

enum ImageCacheCategory {
    case app
    case home
}

enum ImageCacheTTL {
    case appRun
    case acrossLaunch
}

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private var category: ImageCacheCategory
    private var imageTTL: ImageCacheTTL
    private let repo: ImageCacheRepo
    
    init(category: ImageCacheCategory = .app, imageTTL: ImageCacheTTL = .appRun) {
        self.category = category
        self.imageTTL = imageTTL
        self.repo = ImageRepoFactory.getRepo(for: category)
    }
    
    func getImage(url urlString: String) async throws -> Data? {
        if let data = repo[urlString] {
            return data
        }
        
        if let url = URL(string: urlString) {
            let (data, _) = try await URLSession.shared.data(from: url)
            repo.add(key: urlString, value: data)
            return data
        }
        
        return nil
    }
}
