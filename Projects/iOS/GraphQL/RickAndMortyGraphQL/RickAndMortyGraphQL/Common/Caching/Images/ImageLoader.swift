    //
    //  ImageLoader.swift
    //  RickAndMortyGraphQL
    //
    //  Created by mohit.dubey on 18/01/23.
    //

import Foundation
import Combine

class ImageLoader {
    var subscriber = Set<AnyCancellable>()
    var didChange = PassthroughSubject<Data, Never>()
    var data: Data {
        didSet {
            didChange.send(data)
        }
    }
    
    let url: URL
    init(url: URL) {
        self.url = url
        data = Data()
    }
    
    deinit {
        subscriber.forEach { item in
            item.cancel()
        }
        
        subscriber = Set<AnyCancellable>()
    }
    
    func getImage() {
        if let imageData = ImageCache.shared.cache[url.absoluteString] {
            data = imageData
            return
        }
        
            //Network request using combine
        URLSession.shared.dataTaskPublisher(for: url)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Error in image download \(error.localizedDescription)")
                }
            } receiveValue: {[weak self] (data: Data, response: URLResponse) in
                guard let `self` = self else {
                    return
                }
                
                if let urlString = response.url?.absoluteString {
                    ImageCache.shared.setImage(data: data, for: urlString)
                    self.data = data
                }
            }
            .store(in: &subscriber)
    }
}
