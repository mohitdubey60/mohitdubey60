    //
    //  PhotoLibraryService.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 29/11/22.
    //

import Foundation
import Photos

protocol PhotosService {
    func requestAuthorization()
}

class PhotoLibraryService {
    private let fetchOptions: PHFetchOptions

    init(fetchOptions: PHFetchOptions) {
        self.fetchOptions = fetchOptions
        
        fetchOptions.includeHiddenAssets = false
        fetchOptions.sortDescriptors = [ NSSortDescriptor(key: "creationDate", ascending: false) ]
    }
    
    func requestAuthorization(_ completionHandler: @escaping (Bool, [PHAsset]) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) {[weak self] authorizationStatus in
            guard let `self` = self else {
                return
            }
            
            switch authorizationStatus {
                case .restricted, .notDetermined, .denied:
                    completionHandler(false, [])
                case .authorized, .limited:
                    DispatchQueue.main.async {
                        var assets: [PHAsset] = []
                        let fetchResult = PHAsset.fetchAssets(with: .image, options: self.fetchOptions)
                        for i in 0..<fetchResult.count {
                            let asset = fetchResult.object(at: i)
                            assets.append(asset)
                        }
                        
                        completionHandler(true, assets)
                    }
                @unknown default:
                    break
            }
        }
    }
}
