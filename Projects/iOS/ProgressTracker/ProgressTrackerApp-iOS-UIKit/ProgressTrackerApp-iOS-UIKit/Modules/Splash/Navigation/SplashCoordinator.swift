//
//  SplashCoordinator.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 16/02/23.
//

import UIKit

protocol SplashCoordinatorProtocol: AnyObject {
    func navigateToNextAndDestroyCurrent()
}

class SplashCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    
    var parentDelegate: ParentCoordinatorDelegate?
    weak var vc: SplashViewController?
    
    let window: UIWindow?
    weak var navigationController: UINavigationController?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let vc = SplashViewController.getInstance()
        (vc as! SplashViewController).coordinatorDelegate = self
        let navigationController = BaseNavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

extension SplashCoordinator: SplashCoordinatorProtocol {
    func navigateToNextAndDestroyCurrent() {
        if LogManagerFactory.logHoursManager.areLogsAvailable() {
            let coordinator = GoalsDashboardCoordinator(window: window)
            parentDelegate?.addCoordinatorAndRemoveCurrent(coordinator: coordinator)
        } else {
            let coordinator: SetProgressHoursCoordinator = SetProgressHoursCoordinator(window: window)
            parentDelegate?.addCoordinatorAndRemoveCurrent(coordinator: coordinator)
        }
    }
}
