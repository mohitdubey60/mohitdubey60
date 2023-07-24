//
//  NetworkRequestsWithCombine.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 16/07/23.
//

import Foundation
import Combine

enum NetworkRequestsWithCombineErrors: Error {
    case nilResponse
}

class NetworkRequestsWithCombine {
    func networkDataRequestWithError<T: Codable>(for url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .utility))
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func networkRequestFutureWithError<T: Codable>(for url: URL) -> Future<T, Error> {
        return Future { promise in
            let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error {
                    promise(.failure(error))
                }
                
                if (response == nil) || (data == nil) {
                    promise(.failure(NetworkRequestsWithCombineErrors.nilResponse))
                }
                
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data!)
                    promise(.success(decodedObject))
                } catch let error {
                    promise(.failure(error))
                }
            }
            
            urlSessionTask.resume()
        }
    }
}
