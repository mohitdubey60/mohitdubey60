    //
    //  ProductListView.swift
    //  SwiftUIBootcamp
    //
    //  Created by mohit.dubey on 24/07/23.
    //

import SwiftUI

struct ProductListView: View {
    @Binding var category: String
    @ObservedObject var vm: ProductViewModel
    
    var body: some View {
        List(vm.products, id: \.id) { product in
            NavigationLink(value: product) {
                HStack {
                    AsyncImage(url: URL(string: product.images?.first ?? "")) { image in
                        image
                            .resizable()
                            .frame(width: 32, height: 32)
                            .mask {
                                Circle()
                            }
                    } placeholder: {
                        Image(systemName: "star.fill").resizable()
                            .frame(width: 32, height: 32)
                            .mask {
                                Circle()
                            }
                    }

                    
                    
                    Text("\(product.title ?? "")")
                }
            }
        }
        .navigationTitle(category.uppercased())
        .navigationDestination(for: ProductModel.self) { product in
            ProductView(product: product)
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        let category = ProductCategoriesViewModel().getAllProductCategoriesOnSameThread()[0]
        ProductListView(category: .constant(category), vm: ProductViewModel(products: ProductCategoriesViewModel().getProductsOnSameThread(for: category)))
    }
}
