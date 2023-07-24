//
//  CombineSwiftUIView.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 16/07/23.
//

import SwiftUI

struct CombineSwiftUIView: View {
    @ObservedObject var vm: CombineSwiftUIViewModel
    
    var body: some View {
        VStack {
            Button("Load File") {
                vm.getContent(of: "FakeProducts.json")
            }
            if let uiimage = vm.uiimage {
                Image(uiImage: uiimage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipped()
            }
            Button("Load largeImage") {
                vm.uiimage = nil
                vm.getImage()
            }
            Button("Find users average age") {
                vm.getUsers()
            }
        }
    }
}

struct CombineSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CombineSwiftUIView(vm: CombineSwiftUIViewModel())
    }
}
