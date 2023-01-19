//
//  CharacterViewModel.swift
//  RickAndMortyGraphQL
//
//  Created by mohit.dubey on 18/01/23.
//

import Foundation
import UIKit
import Combine

class CharacterViewModel: ObservableObject {
    @Published var character: CharacterModel
    @Published var image: UIImage
    var imageLoader: ImageLoader?
    var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(character: CharacterModel) {
        self.character = character
        image = UIImage(systemName: "person.and.arrow.left.and.arrow.right")!
        if let url = URL(string: self.character.char_image) {
            self.imageLoader = ImageLoader(url: url)
        }
    }
    
    func getImage() {
        imageLoader?
            .didChange
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] data in
                if let _image = UIImage(data: data) {
                    self?.image = _image
                }
            })
            .store(in: &cancellable)
        
        imageLoader?.getImage()
    }
}
