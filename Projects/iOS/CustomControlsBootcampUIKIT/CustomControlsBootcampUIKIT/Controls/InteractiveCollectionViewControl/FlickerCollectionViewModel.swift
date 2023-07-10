//
//  FlickerCollectionViewModel.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 08/06/23.
//

import Foundation

class FlickrCellViewModel: Equatable {
    var photo: FlickrSearchPhoto
    var isSelected: Bool
    
    init(photo: FlickrSearchPhoto, isSelected: Bool = false) {
        self.photo = photo
        self.isSelected = isSelected
    }
    
    static func ==(lhs: FlickrCellViewModel, rhs: FlickrCellViewModel) -> Bool {
        lhs.photo == rhs.photo
    }
}

class FlickerCollectionViewModel {
    let service: FlickerImageSearchService
    let itemsPerRow: Int
    var photosViewModel: [FlickrCellViewModel]
    var selectedItems: [FlickrCellViewModel]
    
    weak var delegate: FlickrCollectionActions?
    
    init(service: FlickerImageSearchService, photos: [FlickrCellViewModel] = [], itemsPerRow: Int, selectedItems: [FlickrCellViewModel] = []) {
        self.service = service
        self.photosViewModel = photos
        self.itemsPerRow = itemsPerRow
        self.selectedItems = selectedItems
    }
    
    func getAllPhotos(for search: String = "house") {
        service.searchImagesFor(tag: search) {[weak self] photos, error in
            if let error {
                return
            }
            
            self?.photosViewModel = photos.map({ FlickrCellViewModel(photo: $0) })
            self?.delegate?.loadCells(with: self?.photosViewModel ?? [])
        }
    }
    
    func getImageForCell(photo: FlickrSearchPhoto) async throws -> (data: Data?, photoModel: FlickrSearchPhoto) {
        do {
            return try await service.getImage(for: photo, size: .smallSquare)
        } catch {
            throw error
        }
    }
    
    func selectItem(at index: Int) {
        photosViewModel[index].isSelected = true
        selectedItems.append(photosViewModel[index])
        delegate?.updateShareVisibility(show: selectedItems.count > 0)
    }
    
    func removeItem(at index: Int) {
        photosViewModel[index].isSelected = false
        if let selectedIndex = selectedItems.firstIndex(where: { $0 == photosViewModel[index] }) {
            selectedItems.remove(at: selectedIndex)
        }
        delegate?.updateShareVisibility(show: selectedItems.count > 0)
    }
    
    func deSelectAll() {
        selectedItems.removeAll()
        delegate?.updateShareVisibility(show: selectedItems.count > 0)
    }
}
