    //
    //  ProductCategoriesViewModel.swift
    //  SwiftUIBootcamp
    //
    //  Created by mohit.dubey on 24/07/23.
    //

import SwiftUI

class ProductCategoriesViewModel: ObservableObject {
    @Published var productCategories: [String] = []
    @Published var products: [ProductModel] = []
    
    func getAllProductCategories(from fileName: String = "ProductCategories.json") {
        @FileToCodableObject(fileNameWithExtension: fileName)
        var fileData: [String]?
        
        DispatchQueue.global(qos: .background).async {
            if let fileData {
                DispatchQueue.main.async {
                    //UI Work here
                    self.productCategories = fileData
                    print("Product Categories count \(self.productCategories.count)")
                }
            }
        }
    }
    
    func getAllProductCategoriesOnSameThread(from fileName: String = "ProductCategories.json") -> [String] {
        @FileToCodableObject(fileNameWithExtension: fileName)
        var fileData: [String]?
        productCategories = fileData ?? []
        return productCategories
    }
    
    func getProductsOnSameThread(for category: String, from fileName: String = "Products.json") -> [ProductModel] {
        @FileToCodableObject(fileNameWithExtension: fileName)
        var fileData: ProductsListModel?
        
        if let fileData {
            products = fileData.products?.filter({ $0.category == category }) ?? []
            return products ?? []
        }
        
        return []
    }
}
