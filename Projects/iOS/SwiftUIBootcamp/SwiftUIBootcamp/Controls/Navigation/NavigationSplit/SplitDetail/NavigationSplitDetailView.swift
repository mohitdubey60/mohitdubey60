//
//  NavigationSplitDetailView.swift
//  SwiftUIBootcamp
//
//  Created by mohit.dubey on 25/07/23.
//

import SwiftUI

struct NavigationSplitDetailView: View {
    @State var vm: ProductCategoriesViewModel
    @State var selectedCategory: String?
    
    var body: some View {
        NavigationSplitView {
            List(vm.getAllProductCategoriesOnSameThread(), id: \.self, selection: $selectedCategory) { item in
                NavigationLink(item, value: item)
            }
        } detail: {
            NavigationStack {
                ProductListGridView(category: selectedCategory ?? "", products: vm.getProductsOnSameThread(for: selectedCategory ?? ""))
            }
        }
        .onAppear {
            selectedCategory = vm.getAllProductCategoriesOnSameThread().first
        }

    }
}

struct NavigationSplitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationSplitDetailView(vm: ProductCategoriesViewModel())
    }
}
