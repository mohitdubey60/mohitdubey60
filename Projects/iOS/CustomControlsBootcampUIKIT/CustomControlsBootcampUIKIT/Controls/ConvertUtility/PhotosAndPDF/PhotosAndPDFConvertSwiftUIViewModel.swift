//
//  PhotosAndPDFConvertSwiftUIViewModel.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 20/07/23.
//

import SwiftUI

enum ConvertFileType {
    case none
    case pdf(URL)
    case png(String)
    case jpg(String)
}

class PhotosAndPDFConvertSwiftUIViewModel: ObservableObject {
    @Published var convertFileType: ConvertFileType?
    @Published var convertTo: String
    @Published var isConverted = false
    @Published var isConvertEnabled = false
    var convertToOptions: [String]
    private var dict: [String: Any] = [
        "PNG": Bundle.main.path(forResource: "photo-2", ofType: "png")!,
        "JPG": Bundle.main.path(forResource: "photo-1", ofType: "jpg")!,
        "PDF": Bundle.main.url(forResource: "PDF sample", withExtension: "pdf")!
    ]
    
    init(convertFileType: ConvertFileType? = nil, convertToOptions: [String] = ["PNG", "PDF", "JPG"]) {
        self.convertFileType = convertFileType
        self.convertToOptions = convertToOptions
        self.convertTo = convertToOptions.first!
    }
    
    func browseFile() {
        
    }
    
    func convert(to fileType: String) {
        convertPNGToPDF(pngImagePath: "")//(jpgImagePath: "")
//        if let localConvertFileType = convertFileType {
//            switch localConvertFileType {
//                case .none:
//                    break
//                case .pdf(let fileURL):
//                    <#code#>
//                case .png(let filePath):
//                    <#code#>
//                case .jpg(let filePath):
//                    <#code#>
//            }
//        }
    }
}

extension PhotosAndPDFConvertSwiftUIViewModel {
    private func createPDF(image: UIImage) -> NSData? {
        let pdfData = NSMutableData()
        let pdfConsumer = CGDataConsumer(data: pdfData as CFMutableData)!
        
        var mediaBox = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        let pdfContext = CGContext(consumer: pdfConsumer, mediaBox: &mediaBox, nil)!
        pdfContext.beginPage(mediaBox: &mediaBox)
        pdfContext.draw(image.cgImage!, in: mediaBox)
        pdfContext.endPage()
        
        return pdfData
    }
    
    private func documentPath() -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func convertPDFToJPG(pdfPath: URL) {
        
    }
    
    func convertPDFToPNG(pdfPath: URL) {
        
    }
    
    func convertJPGToPNG(jpgImagePath: String) {
        let image = UIImage(contentsOfFile: dict["JPG"] as! String)
        if let pngData = image?.pngData(), let docs = documentPath() {
            
            do {
                let destPNG = docs.appendingPathComponent("test.png")
                try pngData.write(to: destPNG)
            } catch {
                print(error)
            }
        }
    }
    
    func convertJPGToPDF(jpgImagePath: String) {
        if let image = UIImage(contentsOfFile: dict["JPG"] as! String),
            let pdfData = createPDF(image: image) {
            
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let docURL = documentDirectory.appendingPathComponent("test.pdf")
            do {
                try pdfData.write(to: docURL)
            } catch let error {
                print("Error in writing the PDF \(error.localizedDescription)")
            }
        }
    }
    
    func convertPNGToJPG(pngImagePath: String) {
        let image = UIImage(contentsOfFile: dict["PNG"] as! String)
        if let jpgData = image?.jpegData(compressionQuality: 1), let docs = documentPath() {
            do {
                let destJPEG = docs.appendingPathComponent("test.jpg")
                try jpgData.write(to: destJPEG)
            } catch {
                print(error)
            }
        }
    }
    
    func convertPNGToPDF(pngImagePath: String) {
        if let image = UIImage(contentsOfFile: dict["PNG"] as! String),
           let pdfData = createPDF(image: image) {
            
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let docURL = documentDirectory.appendingPathComponent("test.pdf")
            do {
                try pdfData.write(to: docURL)
            } catch let error {
                print("Error in writing the PDF \(error.localizedDescription)")
            }
        }
    }
}
