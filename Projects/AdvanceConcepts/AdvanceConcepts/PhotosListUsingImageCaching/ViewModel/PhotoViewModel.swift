//
//  PhotoViewModel.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 28/12/22.
//

import Foundation
import SwiftUI
import Combine

class PhotoViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    let imageUrl: String
    @Published var image: UIImage?
    
    let photoService: PhotosService
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
        self.photoService = PhotosService(imageUrlString: self.imageUrl)
    }
    
    deinit {
        for cancellableItem in cancellable {
            cancellableItem.cancel()
        }
    }
    
    func getImage() {
        photoService.getFile()
        image = nil
        
        photoService.$photo
            .receive(on: DispatchQueue.main)
            .sink {[weak self] image in
                if let image = image {
                    self?.image = image
                }
            }
            .store(in: &cancellable)
    }
}
