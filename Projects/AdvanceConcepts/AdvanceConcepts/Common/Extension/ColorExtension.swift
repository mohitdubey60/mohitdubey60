//
//  ColorExtension.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 23/12/22.
//

import SwiftUI

fileprivate func getRGBFromHex(hex: String) -> (CGFloat, CGFloat, CGFloat, CGFloat)? {
    var hexNormalized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexNormalized = hexNormalized.replacingOccurrences(of: "#", with: "")
    
        // Helpers
    var rgb: UInt32 = 0
    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0
    var a: CGFloat = 1.0
    let length = hexNormalized.count
    
        // Create Scanner
    Scanner(string: hexNormalized).scanHexInt32(&rgb)
    
    if length == 6 {
        r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        b = CGFloat(rgb & 0x0000FF) / 255.0
        
    } else if length == 8 {
        r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
        g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
        b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
        a = CGFloat(rgb & 0x000000FF) / 255.0
        
    } else {
        return nil
    }
    
    return (r, g, b, a)
}

//MARK: - UIKIt Color
extension UIColor {
    
        // MARK: - Initialization
    
    convenience init?(hex: String) {
        if let rgba = getRGBFromHex(hex: hex) {
            self.init(red: rgba.0, green: rgba.1, blue: rgba.2, alpha: rgba.3)
        }
        
        return nil
    }
    
        
        // MARK: - Convenience Methods
    
    var toHex: String? {
            // Extract Components
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
            // Helpers
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
            // Create Hex String
        let hex = String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        
        return hex
    }
}

//MARK: - SwiftUI Color
extension Color {
    init?(hex: String) {
        if let rgba = getRGBFromHex(hex: hex) {
            self.init(red: rgba.0, green: rgba.1, blue: rgba.2, opacity: rgba.3)
        }
        
        return nil
    }
    
    var toHex: String? {
        let uic = UIColor(self)
        return uic.toHex
    }
}
