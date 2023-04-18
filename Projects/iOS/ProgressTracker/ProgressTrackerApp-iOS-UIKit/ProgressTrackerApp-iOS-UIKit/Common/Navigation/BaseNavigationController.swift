//
//  BaseNavigationController.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 16/02/23.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }

    var style: UIStatusBarStyle {
        //return DHUserDefaults.isDarkModeOn ? .lightContent : .default
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: false)
//        self.delegate = NavigationListener.shared
        self.navigationBar.isTranslucent = false
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
