//
//  DashboardCoordinator.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 23/03/23.
//

import UIKit

protocol DashboardCoordinatorNavigation: AnyObject {
    
}

class DashboardCoordinator: BaseCoordinator, Coordinator {
    func start() {
        let dashboardController = RickAndMortyActualDashboardViewControllerFactory.getDashboardController()
        dashboardController.presenter.coordinatorDelegate = self
        navigationController?.pushViewController(dashboardController, animated: true)
    }
}

extension DashboardCoordinator: DashboardCoordinatorNavigation {
    
}
