//
//  GoalsDashboardCoordinator.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 25/02/23.
//

import UIKit

class GoalsDashboardCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    var parentDelegate: ParentCoordinatorDelegate?
    
    let window: UIWindow?
    weak var navigationController: UINavigationController?
    
    init(window: UIWindow?) {
        self.window = window
        navigationController = window?.rootViewController as? UINavigationController
    }
    
    func start() {
        let vc = GoalsDashboardViewController.getInstance()
        if let nc = window?.rootViewController as? UINavigationController {
            navigationController = nc
            nc.pushViewController(vc, animated: true)
        }
    }
}
