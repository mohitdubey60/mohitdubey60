//
//  ImageCache.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 15/11/22.
//

import Foundation

class ImageCache {
    static let shared: ImageCache = ImageCache()
    
    private init() {}
    private let queue = DispatchQueue(label: "", qos: .utility, attributes: .concurrent ,autoreleaseFrequency: .workItem)
    private var _cache: [String : Data] = [:]
    private(set) var cache: [String : Data] {
        get {
            queue.sync {
                _cache
            }
        }
        set {
            queue.sync(flags: .barrier) {
                _cache = newValue
            }
        }
    }
    
    func setImage(data: Data, for url: String) {
        cache[url] = data
    }
}
