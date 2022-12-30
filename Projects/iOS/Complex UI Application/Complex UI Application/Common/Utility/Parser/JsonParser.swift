//
//  JsonParser.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 04/08/22.
//

import Foundation


struct JsonParser {
    static func parseJsonToObject<T: Codable>(data: Data) throws -> T {
        do {
            let object: T = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            throw error
        }
    }
    
    static func parseObjectToJson<T: Codable>(object: T) throws -> Data {
        do {
            let jsonData: Data = try JSONEncoder().encode(object)
            return jsonData
        } catch {
            throw error
        }
    }
}
