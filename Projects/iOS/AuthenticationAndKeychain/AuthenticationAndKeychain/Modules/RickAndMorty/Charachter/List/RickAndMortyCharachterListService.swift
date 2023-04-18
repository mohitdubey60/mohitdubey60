//
//  RickAndMortyCharachterListService.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 25/03/23.
//

import Foundation

class RickAndMortyCharachterListService: RickAndMortyListService {
    
    let initialUrl: String
    init(initialUrl: String) {
        self.initialUrl = initialUrl
        super.init(infoModel: RickAndMortyListInfoModel(current: initialUrl))
    }
    
    func getPageResponse(completion: @escaping ([RickAndMortyCharachterEntity], Error?) -> Void) {
        getNextPageResponse {[weak self] (result: RickAndMortyCharachtersListEntity?, error) in
            guard let self else {
                return
            }
            
            if let _ = error {
                completion([], error)
                return
            }
            
            if let infoModel = result?.info {
                self.infoModel.current = self.infoModel.next ?? ""
                self.infoModel = infoModel
            }
            
            completion(result?.results ?? [], nil)
        }
    }
    
    func refreshPage(completion: @escaping ([RickAndMortyCharachterEntity], Error?) -> Void) {
        infoModel = RickAndMortyListInfoModel(current: initialUrl)
        getPageResponse(completion: completion)
    }
}
