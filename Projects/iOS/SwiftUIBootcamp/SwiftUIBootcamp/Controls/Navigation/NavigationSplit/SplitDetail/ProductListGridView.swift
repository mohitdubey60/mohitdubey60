    //
    //  ProductListGridView.swift
    //  SwiftUIBootcamp
    //
    //  Created by mohit.dubey on 25/07/23.
    //

import SwiftUI

struct ProductListGridView: View {
    let columns: [GridItem] = [GridItem](repeating: GridItem(), count: 3)
    let category: String
    let products: [ProductModel]
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(products, id: \.self) { item in
                    NavigationLink(value: item) {
                        VStack {
                            AsyncImage(url: URL(string: item.images?.first ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: 100, maxHeight: 100)
                                    .clipped()
                                    .mask {
                                        RoundedRectangle(cornerRadius: 12)
                                    }
                            } placeholder: {
                                Image(systemName: "star.fill").resizable()
                                    .frame(width: 32, height: 32)
                                    .mask {
                                        Circle()
                                    }
                            }
                            
                            Text("\(item.title ?? "")")
                        }
                    }
                }
            }
        }
        .navigationTitle(category)
        .navigationDestination(for: ProductModel.self) { product in
            ProductView(product: product)
        }
    }
}

struct ProductListGridView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListGridView(category: ProductCategoriesViewModel().getAllProductCategoriesOnSameThread()[0], products: ProductCategoriesViewModel().getProductsOnSameThread(for: ProductCategoriesViewModel().getAllProductCategoriesOnSameThread()[0]))
    }
}
