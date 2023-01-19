//
//  CharacterModel.swift
//  RickAndMortyGraphQL
//
//  Created by mohit.dubey on 18/01/23.
//

import Foundation

protocol CharacterModel {
    var char_id: String {get}
    var char_name: String {get}
    var char_gender: String {get}
    var char_image: String {get}
    var char_species: String {get}
    var char_episodesCount: Int {get}
    var char_episodes: [EpisodeModel] {get}
}

extension GetAllCharactersQuery.Data.Character.Result: CharacterModel {
    var char_id: String {
        self.id ?? ""
    }
    
    var char_name: String {
        self.name ?? ""
    }
    
    var char_gender: String {
        self.gender ?? ""
    }
    
    var char_image: String {
        self.image ?? ""
    }
    
    var char_species: String {
        self.species ?? ""
    }
    
    var char_episodesCount: Int {
        self.episode.count
    }
    
    var char_episodes: [EpisodeModel] {
        self.episode.compactMap({ $0 })
    }
}

extension GetAllEpisodesQuery.Data.Episode.Result.Character: CharacterModel {
    var char_id: String {
        self.id ?? ""
    }
    
    var char_name: String {
        self.name ?? ""
    }
    
    var char_gender: String {
        ""
    }
    
    var char_image: String {
        self.image ?? ""
    }
    
    var char_species: String {
        ""
    }
    
    var char_episodesCount: Int {
        0
    }
    
    var char_episodes: [EpisodeModel] {
        []
    }
}
