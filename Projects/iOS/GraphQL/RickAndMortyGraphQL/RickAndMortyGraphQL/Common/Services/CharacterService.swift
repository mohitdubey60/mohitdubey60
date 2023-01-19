//
//  CharacterService.swift
//  RickAndMortyGraphQL
//
//  Created by mohit.dubey on 18/01/23.
//

import Foundation

class CharacterService {
    private init() {}
    static let shared = CharacterService()
    
    private var charactersLastUpdated: TimeInterval = 0
    private var characters: [CharacterModel] = [] {
        didSet {
            charactersLastUpdated = Date().timeIntervalSince1970
        }
    }
    
    func getAllCharacters(_ completionHandler: @escaping ([CharacterModel], Error?) -> Void) {
        GraphQLNetwork.shared.apolloClient.fetch(query: GetAllCharactersQuery()) {[weak self] result in
            if let self, !self.characters.isEmpty {
                completionHandler(self.characters, nil)
                return
            }
            
            switch result {
                case .success(let response):
                    if let allCharacters = response.data?.characters?.results?.compactMap({ $0 }) {
                        self?.characters = allCharacters
                        completionHandler(allCharacters, nil)
                    }
                case .failure(let error):
                    print("Failure in GetAllCharachtersQuery \(error.localizedDescription)")
                    completionHandler([], error)
            }
        }
    }
}
