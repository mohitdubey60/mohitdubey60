    //
    //  DummyProductService.swift
    //  Complex UI Application
    //
    //  Created by mohit.dubey on 08/08/22.
    //

import Foundation
import Combine
enum NetworkError: Error {
    case invalidUrl
    case responseError
    case parsingError
    case unknown
}

class DummyProductService {
    static let shared: DummyProductService = DummyProductService()
    private var productListCancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    private var productItemCancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private init() {}
    
    private func urlDataTaskWithPublisher<T: Codable>(_ url: URL) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getProductListWithFuturePromise<T: Codable>(from urlString: String) -> Future<T, Error> {
        return Future<T, Error> {[weak self] promise in
            guard let `self` = self, let url = URL(string: urlString) else {
                return promise(.failure(NetworkError.invalidUrl))
            }
            
            self.urlDataTaskWithPublisher(url)
                .sink { completion in
                    if case let .failure(error) = completion {
                        switch error {
                            case let decodingError as DecodingError:
                                return promise(.failure(decodingError))
                            case let networkError as NetworkError:
                                return promise(.failure(networkError))
                            default: return promise(.failure(NetworkError.unknown))
                        }
                    }
                } receiveValue: { result in
                    return promise(.success(result))
                }
                .store(in: &self.productListCancellables)
        }
    }
    
    func getProductListWithAnyPublisher<T: Codable>(from urlString: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        return urlDataTaskWithPublisher(url)
    }
}
