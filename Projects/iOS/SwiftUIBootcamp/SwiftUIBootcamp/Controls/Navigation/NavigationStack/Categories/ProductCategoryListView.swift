//
//  ProductCategoryListView.swift
//  SwiftUIBootcamp
//
//  Created by mohit.dubey on 24/07/23.
//

import SwiftUI

struct ProductCategoryListView: View {
    @ObservedObject var vm: ProductCategoriesViewModel
    @State var path: [ProductModel] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List(vm.productCategories, id: \.self) { productCategory in
                
                Section(productCategory) {
                    ForEach(vm.getProductsOnSameThread(for: productCategory), id: \.self) { item in
                        NavigationLink(value: item) {
                            ProductView(product: item)
                        }
                    }
                }
            }
            .navigationTitle("Product Categories")
            .navigationDestination(for: ProductModel.self) { product in
                ProductView(product: product)
            }
//            .navigationDestination(for: String.self, destination: { category in
//                ProductListView(category: .constant(category),
//                                vm: ProductViewModel(products: vm.getProductsOnSameThread(for: category)))
//            })
        }
        .onAppear {
            vm.getAllProductCategories()
        }
    }
}

struct ProductCategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCategoryListView(vm: ProductCategoriesViewModel())
    }
}
