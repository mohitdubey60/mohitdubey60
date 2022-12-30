//
//  FileOperations.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 05/08/22.
//

import Foundation

struct FileOperations {
    static func readContentOfFile(name: String, type ext: String = "json") throws -> Data? {
        if let filePath = Bundle.main.path(forResource: name, ofType: ext) {
            let url = URL(fileURLWithPath: filePath)
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                throw error
            }
        }
        
        return nil
    }
}
