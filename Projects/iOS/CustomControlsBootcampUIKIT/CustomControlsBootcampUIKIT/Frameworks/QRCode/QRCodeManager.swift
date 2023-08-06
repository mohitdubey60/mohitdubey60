//
//  QRCodeManager.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 04/08/23.
//

import Foundation

class QRCodeManager {
    private let qrCodeService: QRCodeService
    
    init(qrCodeService: QRCodeService) {
        self.qrCodeService = qrCodeService
    }
    
    func generateQRCode(for stringValue: String) async -> Data? {
        return await qrCodeService.generateQRCode(for: stringValue)
    }
}
