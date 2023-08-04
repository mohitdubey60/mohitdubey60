//
//  ImageConvertManager.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 27/07/23.
//

import Foundation

class ImageConvertManager {
    private let pdfManager: PDFManager = PDFManager()
    
    func convertPDFToJPG(fileAt fileUrl: URL) {
//        if let image = UIImage(contentsOfFile: dict["PNG"] as! String),
//           let pdfData = createPDF(image: image) {
//
//            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//            let docURL = documentDirectory.appendingPathComponent("test.pdf")
//            do {
//                try pdfData.write(to: docURL)
//            } catch let error {
//                print("Error in writing the PDF \(error.localizedDescription)")
//            }
//        }
    }
    
    func convertImageToJPG(fileAt fileUrl: URL) {
        
    }
    
    func convertImageToJPG(identifier itemIdentifier: String) {
        
    }
    
    func convertPDFToPNG(fileAt fileUrl: URL) {
        
    }
    
    func convertImageToPNG(fileAt fileUrl: URL) {
        
    }
    
    func convertImageToPNG(identifier itemIdentifier: String) {
        
    }
}
