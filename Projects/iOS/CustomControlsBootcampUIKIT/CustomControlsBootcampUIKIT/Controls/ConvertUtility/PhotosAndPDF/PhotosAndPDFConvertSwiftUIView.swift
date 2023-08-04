//
//  PhotosAndPDFConvertSwiftUIView.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 20/07/23.
//

import SwiftUI

struct PhotosAndPDFConvertSwiftUIView: View {

    @ObservedObject var pdfCompressVM: PDFCompressViewModel
    
    var body: some View {
        VStack {
            Text("Convert and Compress")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView {
                PDFCompressView(vm: pdfCompressVM)
                
                ConvertToJPGView(vm: ConvertToJPGViewModel(imageManager: ImageConvertManager()))
            }
        }
        .padding()
    }
}

struct PhotosAndPDFConvertSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosAndPDFConvertSwiftUIView(pdfCompressVM: PDFCompressViewModel())
    }
}
