//
//  ApplicationCoordinator.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 16/02/23.
//

import UIKit

protocol ParentCoordinatorDelegate: AnyObject {
    func didFinish(coordinator: Coordinator)
    func addAsChild(viewController: UIViewController)
    func addCoordinatorAndRemoveCurrent(coordinator: Coordinator)
}

extension ParentCoordinatorDelegate {
    func didFinish(coordinator: Coordinator) {
        (self as? Coordinator)?.remove(coordinator: coordinator)
    }
    func addAsChild(viewController: UIViewController) {
    }
    func addCoordinatorAndRemoveCurrent(coordinator: Coordinator){
    }
}

protocol Coordinator: ParentCoordinatorDelegate {
    var coordinators: [Coordinator] { get set }
    /// NOTE: MUST BE DECLARED WEAK
    var parentDelegate: ParentCoordinatorDelegate? { get set }
    
    func start()
    func present()
    func finish()
}

extension Coordinator {
    func add(coordinator: Coordinator) {
        coordinator.parentDelegate = self
        coordinators.append(coordinator)
    }
    
    func add(at index: Int, coordinator: Coordinator) {
        guard index <= coordinators.count else { return }
        coordinator.parentDelegate = self
        coordinators.insert(coordinator, at: index)
    }
    
    func remove(coordinator: Coordinator) {
        coordinators = coordinators.filter { $0 !== coordinator }
    }
    
    func finish() {
        for coordinator in coordinators {
            coordinator.finish()
        }
        parentDelegate?.didFinish(coordinator: self)
    }
}

extension Coordinator {
    func present() {}
}
