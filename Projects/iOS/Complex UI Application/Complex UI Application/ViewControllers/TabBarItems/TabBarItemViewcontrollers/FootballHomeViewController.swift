//
//  FootballHomeViewController.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 04/08/22.
//

import UIKit

class FootballHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
        if let vc = UIStoryboard.getViewController(fromStoryboard: "OneFootball", controllerIdentifier: LineupViewController.self) {
            addChild(vc)
            didMove(toParent: vc)
            
            view.addSubview(vc.view)
            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: vc.view as UIView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: vc.view as UIView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: vc.view as UIView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: vc.view as UIView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)])
        }
    }

}
