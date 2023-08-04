//
//  PHAssetExtension.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 28/07/23.
//

import Photos
import UIKit

extension PHAsset {
    func getImage(options: PHImageRequestOptions? = nil, size: CGSize? = nil, callback: @escaping (UIImage?) -> ()) {
        var imageOptions = options
        if imageOptions == nil {
            imageOptions = PHImageRequestOptions()
            imageOptions?.version = .current
            imageOptions?.isNetworkAccessAllowed = true
            imageOptions?.isSynchronous = true
            imageOptions?.resizeMode = .fast
            imageOptions?.deliveryMode = .highQualityFormat
        }
        
        var imageSize = size
        if imageSize == nil {
            imageSize = CGSizeMake(CGFloat(pixelWidth), CGFloat(pixelHeight))
        }
        DispatchQueue.global(qos: .background).async {
            let manager = PHImageManager.default()
            
//            manager.requestImageDataAndOrientation(for: self, options: options) { data, someString, orientation, info in
//                print("1st")
//                print("Info - \(info?.keys)")
//                print("Orientation - \(orientation)")
//                print("string - \(someString)")
//                print("Data - \(data)")
//
//                if let url = info?["PHImageFileURLKey"] as? URL {
//                    print(url.absoluteString)
//                }
//            }

            manager.requestImage(for: self, targetSize: imageSize!, contentMode: .default, options: imageOptions) { image, info in
                if let url = info?["PHImageFileURLKey"] as? URL {
                    print(url.absoluteString)
                }
                print("Info is \(info?.keys)")
                callback(image)
            }
        }
        
    }
}
