    //
    //  PhotosCellView.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 29/11/22.
    //

import SwiftUI

struct PhotosCellView: View {
    @ObservedObject var viewModel: PhotosCellViewModel
    var body: some View {
        return GeometryReader { geometry in
            VStack {
                if let im = viewModel.image {
                    Image(uiImage: im)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                } else {
                    Color(uiColor: UIColor.random)
                }
            } .onAppear {
                viewModel.getPhoto()
            }
        }
    }
    
    func printDimensions(gp: GeometryProxy) -> some View {
        print("Mohit: Dimensions are \(gp.size.width) \(gp.size.height)")
        return EmptyView()
    }
}

struct PhotosCellView_Previews: PreviewProvider {
    static var previews: some View {
            //        PhotosCellView(viewModel: PhotosCellViewModel(asset: <#T##PHAsset#>, delegate: <#T##CellImageLoadProtocol#>))
        Text("")
    }
}
