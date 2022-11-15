    //
    //  SwiftUIControlsViewModel.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 15/11/22.
    //

import SwiftUI
import Combine

class SwiftUIControlsViewModel: ObservableObject {
    var imageSubscriber: Set<AnyCancellable> = Set<AnyCancellable>()
    @Published var image: UIImage
    var imageLoader: ImageLoader
    var title: String {
        "Network Image"
    }
    var subtitle: String {
        "This is image test"
    }
    var buttonText: String {
        "Click for action"
    }
    
    deinit {
        imageSubscriber.forEach { item in
            item.cancel()
        }
        imageSubscriber = Set<AnyCancellable>()
    }
    
    init(urlString: String) {
        imageLoader = ImageLoader(urlString: urlString)
        image = UIImage(systemName: "gear")!
    }
    
    func getImage() {
        imageLoader.didChange
            .receive(on: DispatchQueue.main)
            .sink {[weak self] data in
                if let _image = UIImage(data: data) {
                    self?.image = _image
                }
            }.store(in: &imageSubscriber)
        
        imageLoader.getImage()
    }
}
