//
//  SwiftUIControlsView.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 15/11/22.
//

import SwiftUI
//"https://www.online-image-editor.com/styles/2019/images/power_girl.png"
struct SwiftUIControlsView: View {
    @ObservedObject var viewModel: SwiftUIControlsViewModel
    var body: some View {
        VStack {
//AsyncImage is available only iOS15 and above
//            AsyncImage(url: URL(string: "https://www.online-image-editor.com/styles/2019/images/power_girl.png")!) { image in
//                image.image?.resizable()
//
//            }
//            .aspectRatio(1.77, contentMode: .fill)
//            .frame(maxHeight: 300)
            VStack {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                Spacer()
                VStack {
                    Text(viewModel.title).font(.largeTitle)
                    Text(viewModel.subtitle)
                    Button {
                        
                    } label: {
                        Text(viewModel.buttonText)
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                    .padding(.all, 10)
                    .background(Color(uiColor: .systemPink))
                    .cornerRadius(10)
                }
                Spacer()
                .padding(.all)
            }
            .frame(maxWidth: 300, maxHeight: 300)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .black, radius: 10, x: 0.0, y: 10)
        }
        .onAppear {
            viewModel.getImage()
        }
    }
}

struct SwiftUIControlsView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIControlsView(viewModel: SwiftUIControlsViewModel(urlString: "https://www.online-image-editor.com/styles/2019/images/power_girl.png"))
    }
}
