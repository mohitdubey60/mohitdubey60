//
//  UrlOfFile.swift
//  SwiftUIBootcamp
//
//  Created by mohit.dubey on 24/07/23.
//

import Foundation

@propertyWrapper
struct UrlOfFile {
    var fileNameWithExtension: String
    var defaultValue: URL?
    
    var wrappedValue: URL? {
        mutating get {
            if let defaultValue {
                return defaultValue
            }
            let fileNameAndExtension = fileNameWithExtension.split(separator: ".")
            if fileNameAndExtension.count > 1 {
                self.defaultValue = Bundle.main.url(forResource: String(fileNameAndExtension.first!), withExtension: String(fileNameAndExtension.last!))
                return self.defaultValue
            }
            
            return nil
        }
    }
    
    var projectedValue: String {
        fileNameWithExtension
    }
}
