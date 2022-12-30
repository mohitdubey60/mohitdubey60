//
//  PhotosListViewModel.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 28/12/22.
//

import Foundation
import SwiftUI
import Combine

class PhotosListViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    var items: [PhotoModel] = [] {
        didSet {
            itemsVM = items.compactMap({ photoItem in
                return PhotosItemViewModel(item: photoItem)
            })
        }
    }
    
    @Published var itemsVM: [PhotosItemViewModel] = []
    
    func getItems() {
        if let pub: AnyPublisher<[PhotoModel], Error> = NetworkCommunicationManager.shared.makeGetAPICall(urlString: "https://jsonplaceholder.typicode.com/photos") {
            pub
                .replaceError(with: [])
                .sink {[weak self] photos in
                    self?.items = photos
                    self?.itemsVM = self?.items.compactMap({ photoItem in
                        return PhotosItemViewModel(item: photoItem)
                    }) ?? []
                }
                .store(in: &cancellable)
        }
    }
}
