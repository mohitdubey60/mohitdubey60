    //
    //  DashboardService.swift
    //  AuthenticationAndKeychain
    //
    //  Created by mohit.dubey on 23/03/23.
    //

import Foundation

protocol DashboardService {
    func getDashboardEntities(completion: @escaping ([DashboardEntity]) -> Void)
}

class DashboardRealService: DashboardService {
    fileprivate func getAllDashboardEntities(_ tag: inout Int, _ entity: RickAndMortyURLsEntity) -> [DashboardEntity] {
        return BottombarType.allCases.compactMap({ item in
            tag += 1
            switch item {
                case .charachter:
                    if let c = entity.characters {
                        return DashboardEntity(title: "R&MC", url: c, imageName: "character.bubble", tag: tag, type: item)
                    }
                case .episode:
                    if let e = entity.episodes {
                        return DashboardEntity(title: "R&ME", url: e, imageName: "4k.tv", tag: tag, type: item)
                    }
                case .location:
                    if let l = entity.locations {
                        return DashboardEntity(title: "R&ML", url: l, imageName: "location.circle.fill", tag: tag, type: item)
                    }
            }
            
            return nil
        })
    }
    
    func getDashboardEntities(completion: @escaping ([DashboardEntity]) -> Void) {
        if let entity = RickAndMortyHandshakeManager.shared.entity {
            var tag = 0
            let dashboardEntities: [DashboardEntity] = getAllDashboardEntities(&tag, entity)
            completion(dashboardEntities)
            return
        }
        completion([])
        return
    }
}


class DashboardMockService: DashboardService {
    func getDashboardEntities(completion: @escaping ([DashboardEntity]) -> Void) {
        completion([])
    }
}
