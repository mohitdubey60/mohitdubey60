    //
    //  HomeTabBarItems.swift
    //  Complex UI Application
    //
    //  Created by mohit.dubey on 04/08/22.
    //

import Foundation
import UIKit

enum HomeTabBarItems: String, CaseIterable {
    case progressTracker = "Progress Tracker"
    case football = "Football"
    case movies = "Movies"
    case photos = "Photos"
    case contacts = "Contacts"
    case restaurants = "Restaurant"
    case combine = "Combine"
    case more = "More"
    
    var viewController: UIViewController? {
        switch self {
            case .football:
                return UIStoryboard.getViewController(controllerIdentifier: FootballHomeViewController.self)
            case .movies:
                return UIStoryboard.getViewController(controllerIdentifier: MovieListViewController.self)
            case .photos:
                return UIStoryboard.getViewController(fromStoryboard: StoryboardName.photos.rawValue, controllerIdentifier: PhotosGalleryHomeViewController.self)
            case .contacts:
                return UIStoryboard.getViewController(controllerIdentifier: ContactsHomeViewController.self)
            case .restaurants:
                return UIStoryboard.getViewController(controllerIdentifier: FootballHomeViewController.self)
            case .combine:
                return UIStoryboard.getViewController(controllerIdentifier: CombineHomeViewController.self)
            case .progressTracker:
                return UIStoryboard.getViewController(controllerIdentifier: ProgressTrackerHomeViewController.self)
            case .more:
                return UIStoryboard.getViewController(controllerIdentifier: MoreTabBarItemsViewController.self)
        }
    }
    
    var iconSelected: UIImage {
        switch self {
            case .football:
                return UIImage(systemName: "sportscourt.fill")!
            case .movies:
                return UIImage(systemName: "display")!
            case .photos:
                return UIImage(systemName: "photo.on.rectangle")!
            case .contacts:
                return UIImage(systemName: "person.2.fill")!
            case .restaurants:
                return UIImage(systemName: "leaf.fill")!
            case .combine:
                return UIImage(systemName: "comb.fill")!
            case .progressTracker:
                return UIImage(systemName: "cpu.fill")!
            case .more:
                return UIImage(systemName: "tablecells.fill.badge.ellipsis")!
        }
    }
    
    var iconUnselected: UIImage {
        switch self {
            case .football:
                return UIImage(systemName: "sportscourt")!
            case .movies:
                return UIImage(systemName: "lock.display")!
            case .photos:
                return UIImage(systemName: "photo")!
            case .contacts:
                return UIImage(systemName: "person.2")!
            case .restaurants:
                return UIImage(systemName: "leaf")!
            case .combine:
                return UIImage(systemName: "comb")!
            case.progressTracker:
                return UIImage(systemName: "cpu.fill")!
            case .more:
                return UIImage(systemName: "tablecells.badge.ellipsis")!
        }
    }
}
