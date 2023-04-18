//
//  RickAndMortyHandshakeService.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 20/03/23.
//

import Foundation
import Combine

protocol RickAndMortyHandshakeService {
    var rickAndMortyUrlsEntityDidChange: PassthroughSubject<RickAndMortyURLsEntity?, Never> { get set}
    func performHandshake()
}

class RickAndMortyNetworkHandshakeService: RickAndMortyHandshakeService {
    var subscriber = Set<AnyCancellable>()
    var rickAndMortyUrlsEntityDidChange = PassthroughSubject<RickAndMortyURLsEntity?, Never>()
    private var rickAndMortyURLsEntity: RickAndMortyURLsEntity? {
        didSet {
            rickAndMortyUrlsEntityDidChange.send(rickAndMortyURLsEntity)
        }
    }
    
    func performHandshake() {
        guard let url = URL(string: RickAndMortyUrls.baseModelsUrl) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .sink { completion in
                if case .failure(_) = completion {
                    Swift.print("Mohit: Error in api request - \(url)")
                }
            } receiveValue: { [weak self] (data: Data, response: URLResponse) in
                do {
                    let result = try JSONDecoder().decode(RickAndMortyURLsEntity.self, from: data)
                    self?.rickAndMortyURLsEntity = result
                } catch let err {
                    Swift.print("Mohit: Error is \(err.localizedDescription)")
                }
            }
            .store(in: &subscriber)
    }
}

class RickAndMortyMockHandshakeService: RickAndMortyHandshakeService {
    var rickAndMortyUrlsEntityDidChange: PassthroughSubject<RickAndMortyURLsEntity?, Never> = PassthroughSubject<RickAndMortyURLsEntity?, Never>()
    
    func performHandshake() {
        Swift.print("Mohit: RickAndMortyMockHandshakeService -> performHandshake")
    }
}
