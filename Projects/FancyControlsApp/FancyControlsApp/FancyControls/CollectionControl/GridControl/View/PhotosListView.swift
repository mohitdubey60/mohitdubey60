    //
    //  PhotosListView.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 29/11/22.
    //

import SwiftUI

struct PhotosListView: View {
    @State var showGridColoumnCountPopover = false
    @State var photosColumn: Int = 3
    @ObservedObject var viewModel: PhotosLibraryViewModel
    
    var photosList: some View {
        ScrollView {
            
            LazyVGrid(columns: getColumns(), spacing: 1) {
                ForEach(0..<viewModel.photosCellViewModels.count) {index in
                    let width = (UIScreen.main.bounds.width / CGFloat(photosColumn))
                    let height = (width * 16) / 9
                    PhotosCellView(viewModel: viewModel.photosCellViewModels[index])
                        .frame(height: height)
                }
            }
            
        }
        .overlay(alignment: .bottom) {
            VStack (spacing: 2) {
                Text("Select Columns")
                    .font(.title3)
                HStack {
                    Button("3") {
                        withAnimation {
                            photosColumn = 3
                        }
                    }
                    .modifier(ShadowedCTAViewWithBackground(background: Color.blue))
                    
                    Button("4") {
                        withAnimation {
                            photosColumn = 4
                        }
                    }
                    .modifier(ShadowedCTAViewWithBackground(background: Color.blue))
                    
                    
                    Button("5") {
                        withAnimation {
                            photosColumn = 5
                        }
                    }
                    .modifier(ShadowedCTAViewWithBackground(background: Color.blue))
                }
                .frame(height: 50)
                .foregroundColor(.white)
            }
            .frame(height: 90)
            .padding(.horizontal)
            .background(Color(uiColor: UIColor.systemBackground))
            .cornerRadius(10)
            .shadow(color: Color(uiColor: UIColor.label), radius: 10)
        }
    }
    
    var body: some View {
        VStack {
            if viewModel.isLibraryready == nil {
                VStack {
                    Spacer()
                    Text("Loading Photos...")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .frame(height: 50)
                .padding(.vertical, 8)
                .modifier(ShadowedCTAViewWithBackground(background: Color(uiColor: UIColor.systemBackground)))
            } else if viewModel.photosCellViewModels.count > 0 {
                photosList
            } else {
                VStack {
                    Spacer()
                    Text("Photos permission missing")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Button("Change permission") {
                        gotoAppPrivacySettings()
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .modifier(ShadowedCTAViewWithBackground(background: .blue))
                    Spacer()
                }
                .frame(height: 100)
                .padding(.vertical, 8)
                .modifier(ShadowedCTAViewWithBackground(background: Color(uiColor: UIColor.systemBackground)))
            }
        }
        .onAppear {
            viewModel.fetchPhotos()
        }
    }
    
    func getColumns() -> [GridItem] {
        let width = (UIScreen.main.bounds.width / CGFloat(photosColumn))
        
//        let gridItem: [GridItem] = (0 ..< photosColumn).map { _ in
//            GridItem(.fixed(width), spacing: 1)
//        }
        
        let gridColumns = Array(repeating:  GridItem(.fixed(width), spacing: 1), count: photosColumn)
        return gridColumns
    }
    
    func gotoAppPrivacySettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url) else {
            assertionFailure("Not able to open App privacy settings")
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

struct PhotosListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosListView(viewModel: PhotosLibraryViewModel(manager: PhotosListManager()))
    }
}
