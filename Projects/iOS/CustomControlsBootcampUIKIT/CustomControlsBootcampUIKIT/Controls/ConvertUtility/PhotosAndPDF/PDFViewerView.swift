//
//  PDFViewerView.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 20/07/23.
//

import UIKit
import SwiftUI
import PDFKit

struct PDFViewerView: UIViewRepresentable {
    let url: URL
    
    init(_ url: URL) {
        self.url = url
    }
    
    func makeUIView(context: UIViewRepresentableContext<PDFViewerView>) -> PDFViewerView.UIViewType {
            // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFViewerView>) {
            // Update the view.
    }
}

