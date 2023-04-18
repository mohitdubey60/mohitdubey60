//
//  SplashCoordinator.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 21/03/23.
//

import UIKit

protocol SplashCoordinatorProtocol: AnyObject {
    func navigateToNextAndDestroyCurrent()
}

class SplashCoordinator: BaseCoordinator, Coordinator {
    
    func start() {
        if let vc: SplashViewController = SplashViewController.getInstance() as? SplashViewController {
            let presenter = SplashPresenter(delegate: vc, coordinatorDelegate: self)
            vc.presenter = presenter
            let nc = BaseNavigationController(rootViewController: vc)
            navigationController = nc
            window?.rootViewController = nc
            window?.makeKeyAndVisible()
        }
    }
}

extension SplashCoordinator: SplashCoordinatorProtocol {
    func navigateToNextAndDestroyCurrent() {
        let coordinator = DashboardCoordinator(window: window, navigationController: navigationController)
        parentDelegate?.addCoordinatorAndRemoveCurrent(coordinator: coordinator)
    }
}
