//
//  UIViewControllerExtension.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 20/03/23.
//

import UIKit

enum Storyboards: String {
    case main = "Main"
    case rickAndMorty = "RickAndMorty"
}

extension UIViewController {
    static func getInstance(from storyboard: Storyboards = .main, bundle: Bundle? = nil) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Self.className)
        return vc
    }
}
