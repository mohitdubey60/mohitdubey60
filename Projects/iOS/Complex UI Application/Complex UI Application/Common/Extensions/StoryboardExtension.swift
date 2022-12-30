//
//  StoryboardExtension.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 05/08/22.
//

import UIKit

extension UIStoryboard {
    static func getViewController<T: UIViewController>(fromStoryboard name: String = StoryboardName.main.rawValue, controllerIdentifier identifier: T.Type) -> T? {
        if let footballHomeVC = UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: String(describing: T.self)) as? T {
            return footballHomeVC
        }
        return nil
    }
}
