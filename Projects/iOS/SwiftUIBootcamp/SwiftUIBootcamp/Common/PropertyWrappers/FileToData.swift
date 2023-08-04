//
//  FileToData.swift
//  SwiftUIBootcamp
//
//  Created by mohit.dubey on 24/07/23.
//

import Foundation

@propertyWrapper
struct FileToData {
    var fileNameWithExtension: String
    var defaultValue: Data?
    
    
    var wrappedValue: Data? {
        mutating get {
            if let defaultValue {
                return defaultValue
            }
            
            @UrlOfFile(fileNameWithExtension: fileNameWithExtension)
            var fileURL: URL?
            if let fileURL {
                do {
                    let data = try Data(contentsOf: fileURL)
                    self.defaultValue = data
                    return data
                } catch let error {
                    print("Error in reading file \(error.localizedDescription)")
                }
            }
            
            return nil
        }
    }
}
