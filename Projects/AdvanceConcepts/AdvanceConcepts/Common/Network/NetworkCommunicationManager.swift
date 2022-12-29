    //
    //  NetworkCommunicationManager.swift
    //  AdvanceConcepts
    //
    //  Created by mohit.dubey on 26/12/22.
    //

import Foundation
import Combine

class NetworkCommunicationManager {
    static let shared = NetworkCommunicationManager()
    private init() {}
    
    private func createURL(fromString urlString: String) -> URL? {
        if let url = URL(string: urlString) {
            return url
        }
        
        return nil
    }
    
    private func validateOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
    
    func makeGetAPICall<T: Codable>(urlString: String) -> AnyPublisher<T, Error>? {
        
        if let url = createURL(fromString: urlString) {
                // 1. create the publisher
                // 2. subscribe publisher on background thread
                // 3. recieve on main chread
                // 4. tryMap (check that the data is good)
                // 5. decode (decode data into Codable)
                // 6. sink (put the item into our app)
                // 7. store (cancel subscription if needed)
            return URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: DispatchQueue.main)
//                .tryMap { (data, response) -> Data in
//                    guard let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode < 300 else {
//                        throw URLError(.badServerResponse)
//                    }
//                    return data
//                }
                .tryMap(validateOutput)
                .decode(type: T.self, decoder: JSONDecoder())
                .eraseToAnyPublisher() //AnyPublisher<Output, Failure>
        }
        
        return nil
    }
    
    func makeImageAPICall<Data>(urlString: String) -> AnyPublisher<Data, Error>? {
        if let url = createURL(fromString: urlString) {
                // 1. create the publisher
                // 2. subscribe publisher on background thread
                // 3. recieve on main chread
                // 4. tryMap (check that the data is good)
                // 5. decode (decode data into Codable)
                // 6. sink (put the item into our app)
                // 7. store (cancel subscription if needed)
            return URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: DispatchQueue.main)
                .tryMap(validateOutput)
                .mapError({ (error) -> Error in
                    return error
                })
                .map { item in
                    
                    return item as! Data
                }
                .eraseToAnyPublisher()
        }
        
        return nil
    }
}
