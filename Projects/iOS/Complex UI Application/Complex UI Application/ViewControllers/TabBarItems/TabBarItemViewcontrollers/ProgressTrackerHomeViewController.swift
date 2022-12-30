//
//  ProgressTrackerHomeViewController.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 12/08/22.
//

import UIKit

class ProgressTrackerHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let vc = UIStoryboard.getViewController(fromStoryboard: "ProgressTracker", controllerIdentifier: ProgressAddTimeSlotsViewController.self), let vcView = vc.view {
            addChild(vc)
            didMove(toParent: vc)
            
            view.addSubview(vc.view)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: vcView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: vcView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: vcView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: vcView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)])
        }
    }

}
