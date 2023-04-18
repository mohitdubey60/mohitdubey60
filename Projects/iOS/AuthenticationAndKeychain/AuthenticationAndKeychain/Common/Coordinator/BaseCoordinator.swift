//
//  BaseCoordinator.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 23/03/23.
//

import UIKit

class BaseCoordinator {
    var coordinators: [Coordinator] = []
    var parentDelegate: ParentCoordinatorDelegate?
    
    let window: UIWindow?
    weak var navigationController: UINavigationController?
    
    init(window: UIWindow?, parentDelegate: ParentCoordinatorDelegate? = nil, navigationController: UINavigationController? = nil) {
        self.parentDelegate = parentDelegate
        self.window = window
        self.navigationController = navigationController ?? (window?.rootViewController as? UINavigationController)
    }
}
