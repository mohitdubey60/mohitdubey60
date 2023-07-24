//
//  PhotosAndPDFConvertSwiftUIView.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 20/07/23.
//

import SwiftUI

struct PhotosAndPDFConvertSwiftUIView: View {

    @ObservedObject var vm: PhotosAndPDFConvertSwiftUIViewModel
    var body: some View {
        VStack {
            Text("File convert")
                .font(.title)
                .padding(.bottom)
            HStack(spacing: 12) {
                Text("Select File")
                
                Button("Browse") {
                    
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            VStack {
                if let convertFileType = vm.convertFileType {
                    switch convertFileType {
                        case .jpg(let filePath):
                            Image(uiImage: UIImage(contentsOfFile: filePath)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 300)
                                .clipped()
                                .mask {
                                    RoundedRectangle(cornerRadius: 12)
                                        .frame(width: 200, height: 300)
                                }
                        case .png(let filePath):
                            Image(uiImage: UIImage(contentsOfFile: filePath)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 300)
                                .clipped()
                                .mask {
                                    RoundedRectangle(cornerRadius: 12)
                                        .frame(width: 200, height: 300)
                                }
                        case .pdf(let fileUrl):
                            PDFViewerView(fileUrl)
                                .frame(width: 200, height: 300).mask {
                                    RoundedRectangle(cornerRadius: 12)
                                        .frame(width: 200, height: 300)
                                }
                        case .none:
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.black)
                                .frame(width: 200, height: 300)
                    }
                }
            }
            .padding(.bottom)
            
            Text("Convert to:")
                .frame(maxWidth: .infinity, alignment: .leading)
            Picker("", selection: $vm.convertTo) {
                ForEach(vm.convertToOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom)
                
            
            HStack {
                Button {
                    vm.convert(to: vm.convertTo)
                } label: {
                    Text("Convert")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                Button {
                    
                } label: {
                    Text("Download")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!vm.isConverted)
            }

            
            Spacer()
        }
        .padding()
    }
}

struct PhotosAndPDFConvertSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosAndPDFConvertSwiftUIView(vm: PhotosAndPDFConvertSwiftUIViewModel(convertFileType:
                .pdf(Bundle.main.url(forResource: "PDF sample", withExtension: "pdf")!)))
    }
}
