//
//  PDFCompressViewModel.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 26/07/23.
//

import Foundation

class PDFCompressViewModel: ObservableObject {
    @Published var isImporterPresent = false
    @Published var compressPercentage: Float = 10
    @Published var selectedFile: URL? = nil
    
    func compressPDF(url: URL, percentage: Int) {
        print("Starting PDF compression")
        if url.startAccessingSecurityScopedResource() {
            defer {
                url.stopAccessingSecurityScopedResource()
            }
            
            let pdfManger = PDFManager()
            pdfManger.loadPDF(at: url)
            do {
                try pdfManger.compressPDF(pages: .all, percentage: percentage)
                print("Successfully created PDF")
            } catch let error {
                print("Error in compressing \(error.localizedDescription)")
            }
        } else {
            print("File read permission denied")
        }
    }
}
