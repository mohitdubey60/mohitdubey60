//
//  DashboardViewController.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 21/03/23.
//

import UIKit
import Combine

protocol DashboardPresenterController: AnyObject {
    
}

class DashboardViewController: UITabBarController {

    var store: Set<AnyCancellable> = Set<AnyCancellable>()
    var presenter: DashboardPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.controllerDidChange
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink {[weak self] result in
                self?.viewControllers = result
            }
            .store(in: &store)

        viewControllers = presenter.controllers
    }
}

extension DashboardViewController: UITabBarControllerDelegate {
    func createTabs() {
        
    }
}

extension DashboardViewController: DashboardPresenterController {
    
}
