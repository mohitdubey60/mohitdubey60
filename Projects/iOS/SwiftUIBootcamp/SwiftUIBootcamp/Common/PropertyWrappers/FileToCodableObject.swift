//
//  FileToCodableObject.swift
//  SwiftUIBootcamp
//
//  Created by mohit.dubey on 24/07/23.
//

import Foundation

@propertyWrapper
struct FileToCodableObject<T: Codable> {
    var fileNameWithExtension: String
    var defaultValue: T? = nil
    
    var wrappedValue: T? {
        mutating get {
            if let defaultValue {
                return defaultValue
            }
            
            @FileToData(fileNameWithExtension: fileNameWithExtension)
            var fileData: Data?
            
            if let fileData {
                do {
                    let decodedValue = try JSONDecoder().decode(T.self, from: fileData)
                    defaultValue = decodedValue
                    return decodedValue
                } catch let error {
                    print("Error in decoding file \(error.localizedDescription)")
                }
            }
            
            return nil
        }
    }
}
