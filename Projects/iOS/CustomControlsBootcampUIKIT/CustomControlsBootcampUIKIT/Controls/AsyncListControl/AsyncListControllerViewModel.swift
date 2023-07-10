//
//  AsyncListControllerViewModel.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 07/07/23.
//

import Foundation

class AsyncListControllerViewModel {
    private let service: AsyncAwaitWebService
    
    init(service: AsyncAwaitWebService) {
        self.service = service
    }
    
    func  getList() throws {
        if let url = URL(string: "https://dummyjson.com/products") {
            Task {
                do {
                    let products = try await service.getProductList(url: url)
                    DispatchQueue.main.async {
                        print("Data received \(products.products?.count ?? 0)")
                    }
                } catch let error {
                    throw error
                }
            }
        }
    }
    
    func getList() async throws -> Products {
        if let url = URL(string: "https://dummyjson.com/products") {
            do {
                return try await service.getProductList(url: url)
            } catch let err {
                throw err
            }
        }
        
        throw FakeServiceError.invalidURL
    }
}
