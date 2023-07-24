//
//  UIVIewControllerExtension.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 14/07/23.
//

import UIKit
import SwiftUI


extension UIViewController {
    func addSwiftUIViewToController(_ swiftUIView: some View) {
        let vc = UIHostingController(rootView: swiftUIView)
        addChild(vc)
        
        @UIViewAutoLayoutConstraint
        var swiftuiView = vc.view
        
        view.addSubview(swiftuiView)
        NSLayoutConstraint.activate([
            swiftuiView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swiftuiView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            swiftuiView.heightAnchor.constraint(equalTo: view.heightAnchor),
            swiftuiView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        vc.didMove(toParent: self)
    }
}
