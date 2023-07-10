//
//  NavigationExperimentFlowViewController.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 09/05/23.
//

import UIKit

class NavigationExperimentFlowViewController: UIViewController {
    private(set) var vm: NavigationExperimentFlowViewModel!
    
    @IBOutlet weak var screenLabel: UILabel!
    @IBOutlet weak var previousActionButton: UIButton!
    @IBOutlet weak var nextActionButton: UIButton!
    
    private func updateScreen() {
        screenLabel.text = currentFlow.rawValue
        nextActionButton.isEnabled = vm.canGoNext
        previousActionButton.isEnabled = vm.canGoBack
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
        vm.load()
    }
    
    func updateViewModel(_ vm: NavigationExperimentFlowViewModel) {
        self.vm = vm
    }

    @IBAction func previousAction(_ sender: Any) {
        vm.movePrevious()
        updateScreen()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        vm.moveNext()
        updateScreen()
    }
}

extension NavigationExperimentFlowViewController: NavigationExperimentFlow {
    var currentFlow: NavigationExperimentFlowType {
        vm.currentFlow
    }
    
    func start() {
        updateScreen()
    }
    
    func moveNext() {
        updateScreen()
    }
    
    func movePrevious() {
        updateScreen()
    }
}
