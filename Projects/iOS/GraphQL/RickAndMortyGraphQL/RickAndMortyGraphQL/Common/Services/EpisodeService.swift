//
//  EpisodeService.swift
//  RickAndMortyGraphQL
//
//  Created by mohit.dubey on 19/01/23.
//

import Foundation

class EpisodeService {
    private init() {}
    static let shared = EpisodeService()
    
    private var episodesLastUpdated: TimeInterval = 0
    private var episodes: [EpisodeModel] = [] {
        didSet {
            episodesLastUpdated = Date().timeIntervalSince1970
        }
    }
    
    func getAllEpisodes(_ completionHandler: @escaping ([EpisodeModel], Error?) -> Void) {
        GraphQLNetwork.shared.apolloClient.fetch(query: GetAllEpisodesQuery()) {[weak self] result in
            if let self, !self.episodes.isEmpty {
                completionHandler(self.episodes, nil)
                return
            }
            
            switch result {
                case .success(let response):
                    if let allEpisodes = response.data?.episodes?.results?.compactMap({ $0 }) {
                        self?.episodes = allEpisodes
                        completionHandler(allEpisodes, nil)
                    }
                case .failure(let error):
                    completionHandler([], error)
            }
        }
    }
}
