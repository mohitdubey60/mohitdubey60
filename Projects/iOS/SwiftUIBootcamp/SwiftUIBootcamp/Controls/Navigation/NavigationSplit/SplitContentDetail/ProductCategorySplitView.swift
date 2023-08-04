//
//  ProductCategorySplitView.swift
//  SwiftUIBootcamp
//
//  Created by mohit.dubey on 25/07/23.
//

import SwiftUI

struct ProductCategorySplitView: View {
    @State private var visibility: NavigationSplitViewVisibility = .all
    @State var vm: ProductCategoriesViewModel
    @State var selectedCategory: String?
    @State var selectedProduct: ProductModel?
    
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List(vm.getAllProductCategoriesOnSameThread(), id: \.self, selection: $selectedCategory) { item in
                NavigationLink(item, value: item)
            }
            .navigationTitle("Product categories")
            .navigationSplitViewColumnWidth(600)
        } content: {
            VStack {
                if let selectedCategory {
                    List(vm.getProductsOnSameThread(for: selectedCategory), id: \.self, selection: $selectedProduct) { item in
                        NavigationLink(value: item) {
                            ProductView(product: item)
                        }
                    }
                } else {
                    Text("No selection")
                }
            }
            .navigationTitle(selectedCategory ?? "")
        } detail: {
            VStack {
                if let selectedProduct {
                    ProductView(product: selectedProduct)
                } else {
                    Text("No selection")
                }
            }
            .navigationTitle(selectedProduct?.title ?? "")
        }
        .navigationSplitViewStyle(.prominentDetail)
        .onAppear {
            selectedCategory = vm.productCategories.first
            selectedProduct =  vm.products.first
        }

    }
}

struct ProductCategorySplitView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCategorySplitView(vm: ProductCategoriesViewModel())
    }
}
