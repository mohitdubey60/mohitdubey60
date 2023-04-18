//
//  AuthenticationViewController.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 19/03/23.
//

import UIKit

class AuthenticationViewController: BaseViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AuthenticationManager.shared.authenticateUser {[weak self] success, authenticationError in
            if let _ = authenticationError {
                self?.blockView()
                return
            }
        }
    }
    
    private func blockView() {
        if let subView = view.subviews.first(where: { $0.tag == 512 }) {
            subView.removeFromSuperview()
        }
        
        let blurView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.tag = 512
        blurView.backgroundColor = .red
        
        view.addSubview(blurView)
        
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
