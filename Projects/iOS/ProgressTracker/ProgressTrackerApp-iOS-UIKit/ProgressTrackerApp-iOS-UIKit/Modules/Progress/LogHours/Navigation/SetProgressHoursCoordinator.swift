//
//  SetProgressHoursCoordinator.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 23/02/23.
//

import UIKit

protocol SetProgressHoursDestinations: AnyObject {
    func navigateToGoalsDashboard()
}

class SetProgressHoursCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    
    var parentDelegate: ParentCoordinatorDelegate?
    weak var vc: SetProgressHoursCoordinator?
    let window: UIWindow?
    weak var navigationController: UINavigationController?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        if let vc = SetProgressHoursViewController.getInstance() as? SetProgressHoursViewController {
            vc.vm = SetProgressHoursViewModel(delegate: vc, coordinator: self, logHoursManager: LogManagerFactory.logHoursManager)
            if let nc = window?.rootViewController as? UINavigationController {
                navigationController = nc
                nc.pushViewController(vc, animated: true)
            }
        }
    }
    
    func present() {
        
    }
}

extension SetProgressHoursCoordinator: SetProgressHoursDestinations {
    func navigateToGoalsDashboard() {
        let coordinator = GoalsDashboardCoordinator(window: window)
        coordinator.start()
        add(coordinator: coordinator)
    }
}
