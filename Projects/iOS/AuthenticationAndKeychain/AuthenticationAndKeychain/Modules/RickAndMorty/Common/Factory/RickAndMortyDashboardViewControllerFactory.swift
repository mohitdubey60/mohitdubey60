//
//  RickAndMortyDashboardViewControllerFactory.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 24/03/23.
//

import UIKit

protocol RickAndMortyDashboardViewControllerFactory {
    static func getViewController(for entity: DashboardEntity) -> BaseViewController?
    static func getDashboardController() -> DashboardViewController
}

struct RickAndMortyActualDashboardViewControllerFactory: RickAndMortyDashboardViewControllerFactory {
    static func getDashboardController() -> DashboardViewController {
        let dashboardController = DashboardViewController.getInstance(from: .rickAndMorty) as! DashboardViewController
        let interactor = DashboardInteractor(service: DashboardRealService())
        let presenter = DashboardPresenter(interactor: interactor, delegate: dashboardController, coordinatorDelegate: nil)
        presenter.getDashboardTabs()
        dashboardController.presenter = presenter
        return dashboardController
    }
    
    static func getViewController(for entity: DashboardEntity) -> BaseViewController? {
        let tabItem = UITabBarItem(title: entity.title, image: UIImage(systemName: entity.imageName), tag: entity.tag)
        switch entity.type {
            case .charachter:
                if let controller = RickAndMortyCharachterListViewController.getInstance(from: .rickAndMorty) as? RickAndMortyCharachterListViewController {
                    controller.tabBarItem = tabItem
                    return controller
                }
            case .episode:
                if let controller = RickAndMortyEpisodeListViewController.getInstance(from: .rickAndMorty) as? RickAndMortyEpisodeListViewController {
                    controller.tabBarItem = tabItem
                    return controller
                }
            case .location:
                if let controller = RickAndMortyEpisodeListViewController.getInstance(from: .rickAndMorty) as? RickAndMortyEpisodeListViewController {
                    controller.tabBarItem = tabItem
                    return controller
                }
        }
        return nil
    }
}
