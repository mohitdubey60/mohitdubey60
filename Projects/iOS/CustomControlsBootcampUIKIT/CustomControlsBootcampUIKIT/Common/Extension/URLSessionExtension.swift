//
//  URLSessionExtension.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 08/06/23.
//

import Foundation
import Combine

extension URLSession {
    enum SessionError: Error {
        case statusCode(HTTPURLResponse)
    }
    
    func dataTaskPublisher<T: Decodable>(for url: URL) -> AnyPublisher<T, Error> {
        self.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .tryMap({ (data, response) in
                if let response = response as? HTTPURLResponse,
                   (200..<300).contains(response.statusCode) == false {
                    throw SessionError.statusCode(response)
                }
                
                return data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
