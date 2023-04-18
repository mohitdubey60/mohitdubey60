//
//  DashboardPresenter.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 23/03/23.
//

import UIKit
import Combine

class DashboardPresenter {
    var controllerDidChange = PassthroughSubject<[BaseViewController], Never>()
    private(set) var controllers: [BaseViewController] = [] {
        didSet {
            controllerDidChange.send(controllers)
        }
    }
    
    let interactor: DashboardInteractor
    weak var coordinatorDelegate: DashboardCoordinatorNavigation?
    weak var  delegate: DashboardPresenterController?
    
    init(interactor: DashboardInteractor,
         delegate: DashboardPresenterController?,
         coordinatorDelegate: DashboardCoordinatorNavigation?) {
        self.interactor = interactor
        self.delegate = delegate
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func getDashboardTabs() {
        interactor.getDashboardEntities {[weak self] dashboardEntities in
            self?.controllers = dashboardEntities.compactMap { entity in
                RickAndMortyActualDashboardViewControllerFactory.getViewController(for: entity)
            }
        }
    }
}
