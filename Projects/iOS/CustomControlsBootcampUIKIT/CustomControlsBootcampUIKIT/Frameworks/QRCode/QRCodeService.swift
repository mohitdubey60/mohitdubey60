//
//  QRCodeService.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 04/08/23.
//

import Foundation
import UIKit

protocol QRCodeService {
    func generateQRCode(for stringValue: String) async -> Data?
}

class QRCodeOSService: QRCodeService  {
    func generateQRCode(for stringValue: String) async -> Data? {
        let data = stringValue.data(using: String.Encoding.ascii)
        if let QRFilter = CIFilter(name: "CIQRCodeGenerator", parameters: nil) {
            QRFilter.setValue(data, forKey: "inputMessage")
            
            guard let QRImage = QRFilter.outputImage else { return nil }
            
            //Scale the QR code
            let transformScale = CGAffineTransform(scaleX: 5.0, y: 5.0)
            let scaledQRImage = QRImage.transformed(by: transformScale)
            let image = UIImage(ciImage: scaledQRImage)

            return image.pngData()
        }
        
        return nil
    }
}
