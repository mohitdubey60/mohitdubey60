    //
    //  PDFManager.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 26/07/23.
    //

import Foundation
import PDFKit

class PDFManager {
    enum PDFPageAccess {
        case all
        case page(number: Int)
    }
    
    private var document: PDFDocument?
    var totalPages: Int {
        document?.pageCount ?? 0
    }
    
    private func documentPath() -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    private func compressPage(at index: Int, percentage compressionPercentage: Int) -> Data? {
        guard totalPages > index else {
            print("Index out of range")
            return nil
        }
        
        guard let document, let page = document.page(at: index) else {
            print("Document is nil")
            return nil
        }
        
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
        let percentage = CGFloat(compressionPercentage) / 100
        let jpegImageData = image.jpegData(compressionQuality: percentage)
        
        return jpegImageData
    }
    
    func loadPDF(at url: URL) { 
        guard let document = PDFDocument(url: url) else {
            print("Document load failed")
            return
        }
        
        self.document = document
    }
    
    func compressPDF(pages: PDFPageAccess, percentage: Int) throws {
        
        print("Compress percentage -> \(Float(percentage) / 100)")
        switch pages {
            case .all:
                var images: [UIImage] = []
                for index in 0..<totalPages {
                    if let data = compressPage(at: index, percentage: percentage), let image = UIImage(data: data) {
                        images.append(image)
                    }
                }
                
                let pdfDocument = PDFDocument()
                images.forEach { image in
                    if let pdfPage = PDFPage(image: image) {
                        pdfDocument.insert(pdfPage, at: pdfDocument.pageCount)
                    }
                }
                
                if let data = pdfDocument.dataRepresentation() , let docs = documentPath() {
                    let destPDFPath = docs.appendingPathComponent("sample.pdf")
                    try data.write(to: destPDFPath)
                }
                
            case .page(number: let number):
                if let data = compressPage(at: number, percentage: percentage), let image = UIImage(data: data) {
                    let pdfDocument = PDFDocument()
                    if let pdfPage = PDFPage(image: image) {
                        pdfDocument.insert(pdfPage, at: 0)
                    }
                    
                    if let data = pdfDocument.dataRepresentation() , let docs = documentPath() {
                        let destPDFPath = docs.appendingPathComponent("sample.pdf")
                        try data.write(to: destPDFPath)
                    }
                }
        }
    }
}
