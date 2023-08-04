//
//  ConvertToJPGView.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 26/07/23.
//

import SwiftUI
import PhotosUI

struct ConvertToJPGView: View {
    @ObservedObject var vm: ConvertToJPGViewModel
    
    var body: some View {
        VStack {
            Group {
                VStack {
                    Text("JPG Convert")
                        .font(.title3)
                    
                    HStack {
                        HStack {
                            Picker("", selection: $vm.jpgSelectedOption) {
                                ForEach(vm.options, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        Button {
                            if vm.jpgSelectedOption == vm.options.last {
                                vm.showPhotos.toggle()
                            } else {
                                vm.showFileImporter.toggle()
                            }
                        } label: {
                            Text("Select")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .fileImporter(isPresented: $vm.showFileImporter, allowedContentTypes: [.pdf]) { result in
                            switch result {
                                case .success(let fileUrl):
                                    vm.selectedFile = fileUrl
                                case .failure(let error):
                                    print("Error in opening file importer \(error)")
                            }
                        }
                        .photosPicker(isPresented: $vm.showPhotos, selection: $vm.selectedPhotos, maxSelectionCount: 5, matching: .any(of: [.images]), photoLibrary: .shared())
                        .onChange(of: vm.selectedPhotos, perform: { newValue in
                            if vm.selectedPhotos.count != 0 {
                                vm.selectedPhotos = []
                                vm.fetchAllPhotos(photosItdentifiers: newValue)
                            }
                        })
                        
                        
                        
                        if vm.selectedFile != nil || vm.currentSelectedPhoto != nil {
                            Button {
                                withAnimation {
                                    vm.selectedFile = nil
                                    vm.currentSelectedPhoto = nil
                                    vm.compressPercentage = 10
                                }
                            } label: {
                                Text("Clear")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    
                    HStack {
                        Text("Quality percentage: ")
                        Text("10")
                        Slider(value: $vm.compressPercentage, in: 10...100, step: 1)
                        Text("100")
                    }
                    if let selectedFile = vm.selectedFile {
                        PDFViewerView(selectedFile)
                            .frame(height: 200)
                    }
                    if let currentSelectedPhoto = vm.currentSelectedPhoto {
                        Image(uiImage: currentSelectedPhoto)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                    
                    if vm.selectedFile != nil || vm.currentSelectedPhoto != nil {
                        VStack (spacing: 4) {
                            Group {
                                Text("Convert To")
                                    .foregroundColor(Color.accentColor)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack {
                                    Button {
                                        if let selectedFile = vm.selectedFile {
                                        }
                                    } label: {
                                        Text("PNG")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.borderedProminent)
                                    
                                    Button {
                                        if let selectedFile = vm.selectedFile {
                                        }
                                    } label: {
                                        Text("JPG")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.borderedProminent)
                                    
                                    Button {
                                        if let selectedFile = vm.selectedFile {
                                            
                                        }
                                    } label: {
                                        Text("PDF")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.borderedProminent)
                                }
                            }
                        }
                        
                        Button {
                            if let selectedFile = vm.selectedFile {
//                                vm.compressPDF(url: selectedFile, percentage: Int(vm.compressPercentage))
                            }
                        } label: {
                            Text("Compress and Download")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .padding()
            .cornerRadius(12)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(.black.opacity(0.5), lineWidth: 2)
                    .blur(radius: 4)
            })
            .padding(.vertical)
            
            
            Spacer()
        }
    }
}

struct ConvertToJPGView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertToJPGView(vm: ConvertToJPGViewModel(imageManager: ImageConvertManager()))
    }
}
