//
//  ApplicationCoordinator.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 16/02/23.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    var parentDelegate: ParentCoordinatorDelegate?
    
    private var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    private let window: UIWindow
    
    init(window: UIWindow, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.window = window
        self.launchOptions = launchOptions
        
        self.window.isHidden = false
    }
    
    func start() {
        let coordinator = SplashCoordinator(window: window)
        coordinator.parentDelegate = self
        coordinators.append(coordinator)
        coordinator.start()
    }
    
    func addCoordinatorAndRemoveCurrent(coordinator: Coordinator) {
        if let nc = (window.rootViewController as? UINavigationController) {
            if nc.viewControllers.count == 1 {
                nc.viewControllers = []
                for coor in coordinators {
                    coor.finish()
                }
            } else {
                nc.popViewController(animated: false)
                coordinators.last?.finish()
            }
        }
        
        coordinators.append(coordinator)
        coordinator.start()
    }
}
