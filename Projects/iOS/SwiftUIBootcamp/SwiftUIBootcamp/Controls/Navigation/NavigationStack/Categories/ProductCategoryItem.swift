//
//  ProductCategoryItem.swift
//  SwiftUIBootcamp
//
//  Created by mohit.dubey on 24/07/23.
//

import SwiftUI

struct ProductCategoryItem: View {
    @Binding var category: String
    var body: some View {
        Text(category)
    }
}

struct ProductCategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        ProductCategoryItem(category: .constant("Smartphones"))
    }
}
