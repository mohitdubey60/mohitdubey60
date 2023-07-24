    //
    //  FileWithUrl.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 14/07/23.
    //

import Foundation

@propertyWrapper
struct FileWithUrl {
    var fileNameWithExtension: String
    
    var wrappedValue: URL? {
        let fileNameAndExtension = fileNameWithExtension.split(separator: ".")
        if fileNameAndExtension.count > 1 {
            return Bundle.main.url(forResource: String(fileNameAndExtension.first!), withExtension: String(fileNameAndExtension.last!))
        }
        
        return nil
    }
    
    var projectedValue: String {
        fileNameWithExtension
    }
}
