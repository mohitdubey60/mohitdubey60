//
//  RickAndMortyHandshakeManager.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 20/03/23.
//

import Foundation
import Combine

class RickAndMortyHandshakeManager {
    let service: RickAndMortyHandshakeService
    var subscriber = Set<AnyCancellable>()
    var entity: RickAndMortyURLsEntity?
    
    static let shared = getInstance()
    
    init(service: RickAndMortyHandshakeService) {
        self.service = service
    }
    
    func subscribeToList(completion: @escaping ()->Void) {
        service.rickAndMortyUrlsEntityDidChange
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: {[weak self] result in
                self?.entity = result
                completion()
            }
            .store(in: &subscriber)
        
        service.performHandshake()
    }
    
    class func getInstance(isMock: Bool = false) -> RickAndMortyHandshakeManager {
        let instance = RickAndMortyHandshakeManager(service: isMock ? RickAndMortyMockHandshakeService() : RickAndMortyNetworkHandshakeService())
        return instance
    }
}
