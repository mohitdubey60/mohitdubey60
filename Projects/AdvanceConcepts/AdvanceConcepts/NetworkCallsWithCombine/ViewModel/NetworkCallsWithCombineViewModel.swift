//
//  NetworkCallsWithCombineViewModel.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 26/12/22.
//

import Foundation
import Combine

class NetworkCallsWithCombineViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    @Published var allPosts: [PostModel] = []
    init() {}
    
    deinit {
        for cancelSub in cancellables {
            cancelSub.cancel()
        }
    }
    
    func getAllUsers() {
        if let pub: AnyPublisher<[PostModel], Error> =
            NetworkCommunicationManager.shared.makeGetAPICall(urlString: APIEndpoints.allPosts) {
            pub.replaceError(with: [])
                .sink {[weak self] allPosts in
                    self?.allPosts = allPosts
                }
                .store(in: &cancellables)
        }
    }
}
