//
//  ProductModel.swift
//  SwiftUIBootcamp
//
//  Created by mohit.dubey on 24/07/23.
//

import Foundation

    // MARK: - Products
struct ProductsListModel: Codable {
    var products: [ProductModel]?
    var total, skip, limit: Int?
}

    // MARK: - Product
struct ProductModel: Codable, Hashable {
    var id: Int?
    var title, description: String?
    var price: Int?
    var discountPercentage, rating: Double?
    var stock: Int?
    var brand, category: String?
    var thumbnail: String?
    var images: [String]?
}
