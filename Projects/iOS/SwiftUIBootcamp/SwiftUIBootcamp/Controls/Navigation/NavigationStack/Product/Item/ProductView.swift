//
//  ProductView.swift
//  SwiftUIBootcamp
//
//  Created by mohit.dubey on 25/07/23.
//

import SwiftUI

struct ProductView: View {
    var product: ProductModel
    
    var body: some View {
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

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let category = ProductCategoriesViewModel().getAllProductCategoriesOnSameThread()[0]
        ProductView(product: ProductCategoriesViewModel().getProductsOnSameThread(for: category)[0])
    }
}
