//
//  EpisodeModel.swift
//  RickAndMortyGraphQL
//
//  Created by mohit.dubey on 19/01/23.
//

import Foundation

protocol EpisodeModel {
    var episode_id: String {get}
    var episode_name: String {get}
    var episode_airDate: String {get}
    var episode_created: String {get}
    var episode_seq: String {get}
    var episode_characters: [CharacterModel] {get}
}


extension GetAllCharactersQuery.Data.Character.Result.Episode: EpisodeModel {
    var episode_id: String {
        self.id ?? ""
    }
    
    var episode_name: String {
        self.name ?? ""
    }
    
    var episode_airDate: String {
        self.airDate ?? ""
    }
    
    var episode_created: String {
        ""
    }
    
    var episode_seq: String {
        self.episode ?? ""
    }
    
    var episode_characters: [CharacterModel] {
        []
    }
}

extension GetAllEpisodesQuery.Data.Episode.Result: EpisodeModel {
    var episode_id: String {
        self.id ?? ""
    }
    
    var episode_name: String {
        self.name ?? ""
    }
    
    var episode_airDate: String {
        self.airDate ?? ""
    }
    
    var episode_created: String {
        self.created ?? ""
    }
    
    var episode_seq: String {
        self.episode ?? ""
    }
    
    var episode_characters: [CharacterModel] {
        self.characters.compactMap({ $0 })
    }
}
