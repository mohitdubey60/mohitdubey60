//
//  PhotosListManager.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 30/11/22.
//

import Foundation
import Photos
import UIKit

class PhotosListManager {
    var assets: [PHAsset]
    private let photoService: PhotoLibraryService
    let imageCachingManager: PHCachingImageManager
    let imageRequestOptions: PHImageRequestOptions
    
    init(assets: [PHAsset] = [],
         photoService: PhotoLibraryService = PhotoLibraryService(fetchOptions: PHFetchOptions()),
         imageCachingManager: PHCachingImageManager = PHCachingImageManager(),
         imageRequestOptions: PHImageRequestOptions = PHImageRequestOptions()) {
        self.assets = assets
        self.photoService = photoService
        self.imageCachingManager = imageCachingManager
        self.imageRequestOptions = imageRequestOptions
        
        self.imageCachingManager.allowsCachingHighQualityImages = false
        
        imageRequestOptions.deliveryMode = .opportunistic
        imageRequestOptions.isNetworkAccessAllowed = true
        imageRequestOptions.isSynchronous = true
        imageRequestOptions.resizeMode = .fast
    }
    
    func startPhotosAssetFetch(_ completion: @escaping (Bool) -> Void) {
        photoService.requestAuthorization {[weak self] isAuthorized, assets in
            guard let `self` = self else {
                return
            }
            self.assets = assets
            completion(isAuthorized)
        }
    }
    
    func getPhoto(with asset: PHAsset, size: CGSize = PHImageManagerMaximumSize, contentMode: PHImageContentMode = .aspectFill) async -> UIImage {
        await withCheckedContinuation {[weak self] continuation in
            self?.imageCachingManager.requestImage(for: asset, targetSize: size, contentMode: contentMode, options: imageRequestOptions) { image, information in
                if let error = information?[PHImageErrorKey] as? Error {
                    print("Mohit: Error in photos \(error.localizedDescription)")
                    return
                }
                
                if let im = image {
                    continuation.resume(returning: im)
//                    print("Mohit: Image result for asset \(asset.localIdentifier)")
                    return
                }
                
//                print("Mohit: Error in photos \"image is Nil\"")
            }
        }
    }
}
