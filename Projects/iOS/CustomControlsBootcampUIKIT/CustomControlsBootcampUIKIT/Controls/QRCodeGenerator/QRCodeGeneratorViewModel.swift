//
//  QRCodeGeneratorViewModel.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 04/08/23.
//

import SwiftUI

class QRCodeGeneratorViewModel: ObservableObject {
    @Published var qrCodeText: String = ""
    @Published var qrImage: UIImage?
    
    private var manager: QRCodeManager
    
    init(manager: QRCodeManager) {
        self.manager = manager
    }
    
    func generateQRCode(for stringValue: String) {
        Task {
            if let result = await manager.generateQRCode(for: stringValue) {
                DispatchQueue.main.async {
                    withAnimation {
                        self.qrImage = UIImage(data: result)
                    }
                }
            }
        }
    }
}
