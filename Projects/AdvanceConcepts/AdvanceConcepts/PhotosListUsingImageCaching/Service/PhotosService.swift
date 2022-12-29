    //
    //  PhotosService.swift
    //  AdvanceConcepts
    //
    //  Created by mohit.dubey on 28/12/22.
    //

import SwiftUI
import Combine

class PhotosService: ObservableObject {
    let cacheManager: ImageCacheProtocol = ImageMemoryCacheManager.shared
    private let imageUrlString: String

    private var cancellable = Set<AnyCancellable>()
    
    init(imageUrlString: String) {
        self.imageUrlString = imageUrlString
    }
    
    @Published var photo: UIImage? = nil
    
    private func setImage(_ url: URL, _ urlString: String) {
        if let publisher: AnyPublisher<Data, Error> = NetworkCommunicationManager.shared.makeImageAPICall(urlString: urlString) {
            publisher
                .sink { completion in
                    switch completion {
                        case .failure(let error):
                            print("Error in setting file \(error)")
                        default:
                            break
                    }
                } receiveValue: {[weak self] (data) in
                    if let image = UIImage(data: data) {
                        print("Received image for \(urlString)")
                        self?.cacheManager.setImage(forStringUrl: urlString, image: image)
                        self?.photo = image
                    }
                }
                .store(in: &cancellable)
        }
    }
    
    func getFile() {
        if let url = URL(string: imageUrlString) {
            
            if let image = cacheManager.getImage(forStringUrl: imageUrlString) {
                print("Mohit: Image is already existing \(imageUrlString)")
                photo = image
            } else {
                print("Mohit: Downloading image")
                setImage(url, imageUrlString)
            }
        }
    }
}
