//
//  ContentView.swift
//  SwiftUIBootcamp
//
//  Created by mohit.dubey on 24/07/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
//            ProductCategoryListView(vm: ProductCategoriesViewModel())
            ProductCategorySplitView(vm: ProductCategoriesViewModel(), selectedCategory: nil, selectedProduct: nil)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
