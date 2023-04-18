//
//  DashboardInteractor.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 23/03/23.
//

import Foundation

class DashboardInteractor {
    let service: DashboardService
    var dashboardEntities: [DashboardEntity]
    
    init(service: DashboardService, dashboardEntities: [DashboardEntity] = []) {
        self.service = service
        self.dashboardEntities = dashboardEntities
    }
    
    func getDashboardEntities(completion: @escaping ([DashboardEntity])->Void) {
        if dashboardEntities.count == 0 {
            service.getDashboardEntities {[weak self] entities in
                self?.dashboardEntities = entities
                completion(entities)
            }
            return
        }
        
        completion(dashboardEntities)
    }
}
