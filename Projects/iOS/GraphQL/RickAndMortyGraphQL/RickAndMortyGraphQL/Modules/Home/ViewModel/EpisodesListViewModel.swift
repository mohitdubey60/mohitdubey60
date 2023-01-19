//
//  EpisodesListViewModel.swift
//  RickAndMortyGraphQL
//
//  Created by mohit.dubey on 19/01/23.
//

import Foundation

class EpisodesListViewModel: ObservableObject {
    @Published var episodes: [EpisodeModel] = []
    
    init() {
        getEpisodes()
    }
    
    func getEpisodes() {
        EpisodeService.shared.getAllEpisodes {[weak self] episodes, error in
            guard let self else {
                return
            }
            
            if let error {
                print("Mohit: Error in fetching the characters \(error.localizedDescription)")
                return
            }
            
            self.episodes = episodes
        }
    }
}
