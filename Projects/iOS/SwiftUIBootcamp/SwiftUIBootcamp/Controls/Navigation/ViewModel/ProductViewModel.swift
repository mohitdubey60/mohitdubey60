//
//  ProductViewModel.swift
//  SwiftUIBootcamp
//
//  Created by mohit.dubey on 24/07/23.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [ProductModel]
    @Published var product: ProductModel?
    
    init(products: [ProductModel]) {
        self.products = products
        self.product = nil
    }
    
    init(product: ProductModel) {
        self.products = []
        self.product = product
    }
}
