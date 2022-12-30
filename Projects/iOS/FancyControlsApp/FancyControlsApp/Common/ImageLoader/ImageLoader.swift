    //
    //  ImageLoader.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 15/11/22.
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
    
    let urlString: String
    init(urlString: String) {
        self.urlString = urlString
        data = Data()
    }
    
    deinit {
        subscriber.forEach { item in
            item.cancel()
        }
        
        subscriber = Set<AnyCancellable>()
    }
    
    func getImage() {
        if let imageData = ImageCache.shared.cache[urlString] {
            data = imageData
            return
        }
        
        if let url = URL(string: urlString) {
            
                // Traditional way of calling network request
                //            let request = URLRequest(url: url)
                //            let task = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
                //                guard let `self` = self else {
                //                    return
                //                }
                //
                //                if let _ = error {
                //                    return
                //                }
                //
                //                if let _data = data, let urlString = response?.url?.absoluteString {
                //                    ImageCache.shared.setImage(data: _data, for: urlString)
                //                    self.data = _data
                //                }
                //            }
                //
                //            task.resume()
            
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
}
