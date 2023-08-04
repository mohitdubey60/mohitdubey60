//
//  PDFCompressView.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 26/07/23.
//

import SwiftUI

struct PDFCompressView: View {
    @ObservedObject var vm: PDFCompressViewModel
    
    var body: some View {
        VStack {
            Group {
                VStack {
                    Text("PDF Compress")
                        .font(.title3)
                    
                    HStack {
                        Text("PDF")
                        Button {
                            vm.isImporterPresent.toggle()
                        } label: {
                            Text("Select")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .fileImporter(isPresented: $vm.isImporterPresent, allowedContentTypes: [.pdf]) { result in
                            switch result {
                                case .success(let fileurl):
                                    print("Selected file url is \(fileurl.absoluteString)")
                                    withAnimation {
                                        vm.selectedFile = fileurl
                                    }
                                    
                                case .failure(let error):
                                    print("Error in file selection \(error)")
                            }
                        }
                        
                        if let _ = vm.selectedFile {
                            Button {
                                withAnimation {
                                    vm.selectedFile = nil
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
                    
                    if let _ = vm.selectedFile {
                        HStack {
                            Button {
                                if let selectedFile = vm.selectedFile {
                                    vm.compressPDF(url: selectedFile, percentage: Int(vm.compressPercentage))
                                }
                            } label: {
                                Text("Convert to PNG")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            
                            Button {
                                if let selectedFile = vm.selectedFile {
                                    vm.compressPDF(url: selectedFile, percentage: Int(vm.compressPercentage))
                                }
                            } label: {
                                Text("Convert to JPG")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        
                        Button {
                            if let selectedFile = vm.selectedFile {
                                vm.compressPDF(url: selectedFile, percentage: Int(vm.compressPercentage))
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

struct PDFCompressView_Previews: PreviewProvider {
    static var previews: some View {
        PDFCompressView(vm: PDFCompressViewModel())
    }
}
