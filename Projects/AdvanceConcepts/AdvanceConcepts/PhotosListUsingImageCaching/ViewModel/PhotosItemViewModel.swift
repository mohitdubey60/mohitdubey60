//
//  PhotosItemViewModel.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 28/12/22.
//

import Foundation
import SwiftUI

class PhotosItemViewModel: ObservableObject, Identifiable {
    let item: PhotoModel
    
    @Published var thumbnailImageViewModel: PhotoViewModel?
    @Published var iconImageViewModel: PhotoViewModel?
    @Published var title: String?
    @Published var thumbnailUrl: String?
    
    init(item: PhotoModel) {
        self.item = item
        self.title = self.item.title
        self.thumbnailUrl = self.item.thumbnailURL
        
        if let thumbnailUrl = item.thumbnailURL {
            thumbnailImageViewModel = PhotoViewModel(imageUrl: thumbnailUrl)
        }
        
        if let iconUrl = item.url {
            iconImageViewModel = PhotoViewModel(imageUrl: iconUrl)
        }
    }
}
