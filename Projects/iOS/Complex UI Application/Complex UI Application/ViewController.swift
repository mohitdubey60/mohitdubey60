//
//  ViewController.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 04/08/22.
//

import UIKit

class ViewController: UITabBarController {

    private func setupTabBarItems() {
        var vcs: [UIViewController] = []
        var allCases: [HomeTabBarItems] = HomeTabBarItems.allCases.filter { item in
            item != .more
        }
        if allCases.count > 5 {
            allCases = Array(HomeTabBarItems.allCases[0..<4])
            allCases.append(.more)
        }
        
        for caseItem in allCases {
            if let controller = caseItem.viewController {
                let tabBarItem = UITabBarItem(title: caseItem.rawValue, image: caseItem.iconUnselected, selectedImage: caseItem.iconSelected)
                controller.tabBarItem = tabBarItem
                vcs.append(controller)
            }
        }
        viewControllers = vcs
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        delegate = self
        setupTabBarItems()
    }
}

extension ViewController: UITabBarControllerDelegate {
    
}
