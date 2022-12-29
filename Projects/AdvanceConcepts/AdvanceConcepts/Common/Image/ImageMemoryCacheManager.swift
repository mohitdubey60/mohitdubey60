//
//  ImageMemoryCacheManager.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 28/12/22.
//

import Foundation
import SwiftUI

class ImageMemoryCacheManager: ImageCacheProtocol {
    static let shared: ImageMemoryCacheManager = ImageMemoryCacheManager()
    private init(){
        let tempCache = NSCache<NSString, UIImage>()
        tempCache.countLimit = 100
        tempCache.totalCostLimit = 1024 * 1024 * 50 //50mb
        self.cache = tempCache
    }
    
    private var cache: NSCache<NSString, UIImage>
    
    func setImage(forStringUrl urlString: String, image: UIImage) {
        cache.setObject(image, forKey: urlString as NSString)
    }
    
    func getImage(forStringUrl urlString: String) -> UIImage? {
        if let image: UIImage = cache.object(forKey: urlString as NSString) {
            return image
        }
        
        return nil
    }
    
    func removeImage(forStringUrl urlString: String) {
        cache.removeObject(forKey: urlString as NSString)
    }
}
