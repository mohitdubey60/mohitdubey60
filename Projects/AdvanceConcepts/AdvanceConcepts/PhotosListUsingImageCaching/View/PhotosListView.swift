//
//  PhotosListView.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 28/12/22.
//

import SwiftUI

struct PhotosListView: View {
    @ObservedObject var vm = PhotosListViewModel()
    
    var body: some View {
        List(vm.itemsVM) { itemViewModel in
            PhotosItemView(vm: itemViewModel)
                .frame(height: 300)
        }
        .listStyle(.plain)
        .onAppear {
            vm.getItems()
        }
    }
}

struct PhotosListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosListView()
    }
}
