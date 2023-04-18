//
//  RickAndMortyListService.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 25/03/23.
//

import Foundation
import Combine

enum NetworkError: Error {
    case incorrectURL
}

class RickAndMortyListService {
    var store: Set<AnyCancellable> = Set<AnyCancellable>()
    var infoModel: RickAndMortyListInfoModel
    
    init(infoModel: RickAndMortyListInfoModel) {
        self.infoModel = infoModel
    }
    
    func getNextPageResponse<T: Codable>(completion: @escaping (T?, Error?) -> Void) {
        if let url = URL(string: infoModel.next ?? "") {
            URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global())
                .sink { sinkComplete in
                    if case .failure(let error) = sinkComplete {
                        completion(nil, error)
                        return
                    }
                } receiveValue: { [weak self] (data: Data, response: URLResponse) in
                    do {
                        let result: T = try JSONDecoder().decode(T.self, from: data)
                        completion(result, nil)
                    } catch let err {
                        completion(nil, err)
                    }
                }
                .store(in: &store)
            return
        }
        
        completion(nil, NetworkError.incorrectURL)
        return
    }
}
