//
//  CharacterListViewModel.swift
//  RickAndMortyGraphQL
//
//  Created by mohit.dubey on 18/01/23.
//

import SwiftUI
import Combine

class CharacterListViewModel: ObservableObject {
    @Published var allCharacters: [CharacterModel] = []
    
    init() {
        getAllCharacter()
    }
    
    func getAllCharacter() {
        CharacterService.shared.getAllCharacters {[weak self] characters, error in
            guard let self else {
                return
            }
            
            if let error {
                print("Mohit: Error in fetching the characters \(error.localizedDescription)")
                return
            }
            
            self.allCharacters = characters
        }
    }
}
