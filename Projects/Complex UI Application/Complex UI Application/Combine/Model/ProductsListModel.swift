//
//  ProductsListModel.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 08/08/22.
//

import Foundation

    // MARK: - ProductsListModel
class DummyProductsListModel: Codable {
    var products: [DummyProductModel]?
    var total, skip, limit: Int?
    
    init(products: [DummyProductModel]?, total: Int?, skip: Int?, limit: Int?) {
        self.products = products
        self.total = total
        self.skip = skip
        self.limit = limit
    }
}

    // MARK: - Product
class DummyProductModel: Codable {
    var id: Int?
    var title, productDescription: String?
    var price: Int?
    var discountPercentage, rating: Double?
    var stock: Int?
    var brand, category: String?
    var thumbnail: String?
    var images: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case productDescription = "description"
        case price, discountPercentage, rating, stock, brand, category, thumbnail, images
    }
    
    init(id: Int?, title: String?, productDescription: String?, price: Int?, discountPercentage: Double?, rating: Double?, stock: Int?, brand: String?, category: String?, thumbnail: String?, images: [String]?) {
        self.id = id
        self.title = title
        self.productDescription = productDescription
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.images = images
    }
}
