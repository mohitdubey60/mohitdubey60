//
//  ImageUtility.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 05/08/22.
//

import Photos
import Foundation

struct PHPhotosUtility {
    static let shared = PHPhotosUtility()
    private init() {
        
    }
    func getImageFromAsset(asset: PHAsset, completionHandler: @escaping (Data?, CGImagePropertyOrientation?) -> Void, failureHandler: @escaping () -> Void) {
        PHImageManager.default().requestImageDataAndOrientation(for: asset, options: .none) { data, description, orientation, anyHashableDict in
            if data == nil {
                failureHandler()
                return
            }
            
            completionHandler(data, orientation)
        }
    }
}
