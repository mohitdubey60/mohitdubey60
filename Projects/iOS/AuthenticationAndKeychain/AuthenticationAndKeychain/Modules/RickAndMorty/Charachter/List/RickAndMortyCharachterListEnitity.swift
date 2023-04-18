//
//  RickAndMortyCharachterListEnitity.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 25/03/23.
//

import Foundation

protocol RickAndMortyList: Codable {
    associatedtype Entity: Codable
    
    var info: RickAndMortyListInfoModel? { get set }
    var results: [Entity]? { get set }
}

struct RickAndMortyCharachtersListEntity: RickAndMortyList {
    var info: RickAndMortyListInfoModel?
    var results: [RickAndMortyCharachterEntity]?
}
    // MARK: - Info

    // MARK: - Result
struct RickAndMortyCharachterEntity: Codable {
    var id: Int?
    var name: String?
    var status: RickAndMortyCharachterStatusEntity?
    var species: RickAndMortyCharachterSpeciesEntity?
    var type: String?
    var gender: RickAndMortyCharachterGenderEntity?
    var origin, location: RickAndMortyCharachterLocationEntity?
    var image: String?
    var episode: [String]?
    var url: String?
    var created: String?
}

enum RickAndMortyCharachterGenderEntity: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

    // MARK: - Location
struct RickAndMortyCharachterLocationEntity: Codable {
    var name: String?
    var url: String?
}

enum RickAndMortyCharachterSpeciesEntity: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum RickAndMortyCharachterStatusEntity: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
