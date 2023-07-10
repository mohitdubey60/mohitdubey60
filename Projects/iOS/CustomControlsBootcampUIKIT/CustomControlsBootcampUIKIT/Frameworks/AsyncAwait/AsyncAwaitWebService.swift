//
//  AsyncAwaitWebService.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 05/07/23.
//

import Foundation

    // MARK: - Products
struct Products: Codable {
    var products: [Product]?
    var total, skip, limit: Int?
}

    // MARK: - Product
struct Product: Codable {
    var id: Int?
    var title, description: String?
    var price: Int?
    var discountPercentage, rating: Double?
    var stock: Int?
    var brand, category: String?
    var thumbnail: String?
    var images: [String]?
}

enum FakeServiceError: Error {
    case invalidData
    case invalidURL
}

class AsyncAwaitWebService {
    func getProductList(url: URL, _ completion: @escaping (Result<Products, Error>) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                completion(.failure(FakeServiceError.invalidData))
                return
            }
            if let error {
                completion(.failure(error))
                return
            }
            do {
                let productsObject = try JSONDecoder().decode(Products.self, from: data)
                completion(.success(productsObject))
                return
            } catch let error {
                completion(.failure(error))
                return
            }
        }
        
        task.resume()
    }
    
    //This function will calls the campletion handler function from inside
    //and change that implementation to async/await
    func getProductList(url: URL) async throws -> Products {
        try await withCheckedThrowingContinuation { continuation in
            getProductList(url: url) { result in
                switch result {
                    case .success(let products):
                        continuation.resume(returning: products)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getProductListAsync(url: URL) async throws -> Products {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let products = try JSONDecoder().decode(Products.self, from: data)
            return products
        } catch let error {
            throw error
        }
    }
}
