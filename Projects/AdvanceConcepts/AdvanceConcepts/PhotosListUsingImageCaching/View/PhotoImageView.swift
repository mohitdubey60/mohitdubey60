//
//  PhotoImageView.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 28/12/22.
//

import SwiftUI

struct PhotoImageView: View {
    @ObservedObject var vm: PhotoViewModel
    
    init(vm: PhotoViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                VStack {}
            }
        }
        .onAppear {
            vm.getImage()
        }
    }
}

struct PhotoImageView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoImageView(vm: PhotoViewModel(imageUrl: "https://via.placeholder.com/600/92c952"))
            .previewLayout(.fixed(width: 200, height: 200))
            .padding()
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .dark)
            .previewDisplayName("Dark Mode")
        
        PhotoImageView(vm: PhotoViewModel(imageUrl: "https://via.placeholder.com/600/92c952"))
            .previewLayout(.fixed(width: 200, height: 200))
            .padding()
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .light)
            .previewDisplayName("Light Mode")
    }
}
