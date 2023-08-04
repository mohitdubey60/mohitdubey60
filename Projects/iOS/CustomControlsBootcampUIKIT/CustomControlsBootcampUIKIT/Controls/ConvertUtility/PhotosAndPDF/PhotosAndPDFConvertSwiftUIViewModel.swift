//
//  PhotosAndPDFConvertSwiftUIViewModel.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 20/07/23.
//

import SwiftUI
import PDFKit

enum ConvertFileType {
    case none
    case pdf(URL)
    case png(String)
    case jpg(String)
}

//PDF CONVERSION: https://pspdfkit.com/blog/2020/convert-pdf-to-image-in-swift/

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
    
    private func pdfUtility(path pdfPath: URL) -> (pdfPageCount: Int, pdfDocument: PDFDocument)? {
        guard let document = PDFDocument(url: pdfPath) else {
            return nil
        }
        
        let totalPages = document.pageCount
        
        return (totalPages, document)
    }
    
    private func drawPDFPage(page: PDFPage) -> UIImage {
        let pageRect = page.bounds(for: .mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        
        let image = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(CGRect(x: 0, y: 0, width: pageRect.width, height: pageRect.height))
            
                // Translate the context so that we only draw the `cropRect`.
            ctx.cgContext.translateBy(x: -pageRect.origin.x, y: pageRect.size.height - pageRect.origin.y)
            
                // Flip the context vertically because the Core Graphics coordinate system starts from the bottom.
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            
                // Draw the PDF page.
            page.draw(with: .mediaBox, to: ctx.cgContext)
        }
        
        return image
    }
    
    func convertPDFToJPG(pdfPath: URL) {
        guard let result = pdfUtility(path: pdfPath) else {
            return
        }
        
        guard let page = result.pdfDocument.page(at: 0) else {
            return
        }
        
        let image = drawPDFPage(page: page)
        
    }
    
    func convertPDFToPNG(pdfPath: URL) {
        guard let result = pdfUtility(path: pdfPath) else {
            return
        }
        
        guard let page = result.pdfDocument.page(at: 0) else {
            return
        }
        
        let image = drawPDFPage(page: page)
        
        
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
