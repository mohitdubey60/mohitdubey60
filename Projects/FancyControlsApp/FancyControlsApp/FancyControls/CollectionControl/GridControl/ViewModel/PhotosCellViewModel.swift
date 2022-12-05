    //
    //  PhotosCellViewModel.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 30/11/22.
    //

import Foundation
import Photos
import UIKit

class PhotosCellViewModel: ObservableObject {
    let asset: PHAsset
    weak var delegate: CellImageLoadProtocol?
    @Published var image: UIImage? = nil
    let size: CGSize
    var isVisible = false
    
    init(asset: PHAsset, delegate: CellImageLoadProtocol) {
        self.asset = asset
        self.delegate = delegate
        
        let width = UIScreen.main.bounds.width / 3
        let height = width * 16 / 9
        
        size = CGSize(width: width, height: height)
    }
    
    func getPhoto() {
        isVisible = true
        Task {
            await delegate?.loadCell(asset: asset, size: size, completionHandler: {im, error in
                if let err = error {
                    print("Mohit: Error in Image load \(err.localizedDescription)")
                    return
                }
                DispatchQueue.main.async {[weak self] in
                    if self?.isVisible == true {
                        self?.image = im
                    }
                }
            })
        }
    }
    
    func freePhoto() {
        image = nil
        isVisible = false
    }
}
