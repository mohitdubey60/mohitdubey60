    //
    //  PhotosLibraryViewModel.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 30/11/22.
    //

import Foundation
import UIKit
import Photos

protocol CellImageLoadProtocol: AnyObject {
    func loadCell(asset: PHAsset, size: CGSize, completionHandler: @escaping (UIImage?, Error?) -> Void) async
}

class PhotosLibraryViewModel: ObservableObject {
    @Published var isLibraryready: Bool? = nil
    private let manager: PhotosListManager
    @Published var photosCellViewModels: [PhotosCellViewModel] = []
    
    init(manager: PhotosListManager) {
        self.manager = manager
    }
    
    func fetchPhotos() {
        manager.startPhotosAssetFetch {[weak self] result in
            guard let `self` = self else {
                return
            }
            
            DispatchQueue.main.async {
                self.isLibraryready = result
                self.photosCellViewModels = self.manager.assets.map({ PhotosCellViewModel(asset: $0, delegate: self) })
            }
        }
    }
}

extension PhotosLibraryViewModel: CellImageLoadProtocol {
    func loadCell(asset: PHAsset, size: CGSize, completionHandler: @escaping (UIImage?, Error?) -> Void) async {
        Task {
            let image = await manager.getPhoto(with: asset, size: size)
            completionHandler(image, nil)
        }
    }
}
