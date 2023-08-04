//
//  ConvertToJPGViewModel.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 26/07/23.
//

import Foundation
import SwiftUI
import _PhotosUI_SwiftUI

class ConvertToJPGViewModel: ObservableObject {
    @Published var jpgSelectedOption = "PDF"
    var options: [String] = ["PDF", "Image"]
    @Published var showFileImporter = false
    var currentPhotoIdentifier: String?
    @Published var selectedPhotos: [PhotosPickerItem] = [] {
        didSet {
            if selectedPhotos.count > 0 {
                //Do something here
                currentPhotoIdentifier = selectedPhotos.first?.itemIdentifier
            }
        }
    }
    @Published var showPhotos: Bool = false
    @Published var compressPercentage: Float = 10
    @Published var selectedFile: URL? = nil
    @Published var currentSelectedPhoto: UIImage?
    
    let imageManager: ImageConvertManager
    
    init(jpgSelectedOption: String = "PDF",
         showFileImporter: Bool = false,
         selectedPhotos: [PhotosPickerItem] = [],
         showPhotos: Bool = false,
         compressPercentage: Float = 10,
         selectedFile: URL? = nil,
         imageManager: ImageConvertManager) {
        self.jpgSelectedOption = jpgSelectedOption
        self.showFileImporter = showFileImporter
        self.selectedPhotos = selectedPhotos
        self.showPhotos = showPhotos
        self.compressPercentage = compressPercentage
        self.selectedFile = selectedFile
        self.imageManager = imageManager
    }
    
    func fetchAllPhotos(photosItdentifiers: [PhotosPickerItem]) {
        if let pickerIdentfiers = currentPhotoIdentifier {
            self.currentSelectedPhoto = nil
            if let resultAsset = PHAsset.fetchAssets(withLocalIdentifiers: [pickerIdentfiers], options: nil).firstObject {
                resultAsset.getImage { image in
                    guard let image else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        withAnimation(Animation.linear) {
                            self.currentSelectedPhoto = image
                        }
                    }
                }
            }
        }
        
    }
}
