//
//  RickAndMortyListInfoModel.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 25/03/23.
//

import Foundation

struct RickAndMortyListInfoModel: Codable {
    var count, pages: Int?
    var current: String
    var next: String?
    var prev: String?
}
