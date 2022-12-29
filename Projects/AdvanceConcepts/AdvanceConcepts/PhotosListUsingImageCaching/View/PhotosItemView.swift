//
//  PhotosItemView.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 28/12/22.
//

import SwiftUI

struct PhotosItemView: View {
    @ObservedObject var vm: PhotosItemViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack {
                    if vm.thumbnailImageViewModel != nil {
                        PhotoImageView(vm: vm.thumbnailImageViewModel!)
                    } else {
                        Image(systemName: "person.circle")
                    }
                }
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(vm.title ?? "")
                        .font(.headline)
                    Text("ThumbnailUrl: \(vm.thumbnailUrl ?? "")")
                        .foregroundColor(.secondary)
                }
            }
            
            ZStack {
                if vm.iconImageViewModel != nil {
                    PhotoImageView(vm: vm.iconImageViewModel!)
                        .scaledToFill()
                } else {
                    Image(systemName: "person.circle")
                }
            }
            .frame(height: 200)
            .clipped()
            .cornerRadius(10)
        }
    }
}

struct PhotosItemView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosItemView(vm: PhotosItemViewModel(item: PhotoModel(albumID: 1, id: 1, title: "Dummy title",
                                                                url: "https://via.placeholder.com/600/92c952",
                                                                thumbnailURL: "https://via.placeholder.com/150/92c952")))
        .frame(height: 300)
    }
}
