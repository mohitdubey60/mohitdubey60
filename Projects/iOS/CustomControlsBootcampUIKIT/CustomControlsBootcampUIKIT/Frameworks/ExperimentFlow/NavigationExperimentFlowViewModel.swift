//
//  NavigationExperimentFlowViewModel.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 09/05/23.
//

import Foundation

protocol NavigationExperimentFlow: AnyObject {
    var currentFlow: NavigationExperimentFlowType { get }
    
    func moveNext()
    func movePrevious()
    func start()
}

class NavigationExperimentFlowViewModel {
    weak var delegate: NavigationExperimentFlow?
    var manager: ExperimentFlowManager
    var canGoNext: Bool {
        manager.isNextAvailable
    }
    var canGoBack: Bool {
        manager.isPreviousAvailable
    }
    var isNextEnabled: Bool {
        manager.isNextAvailable
    }
    var isPreviousEnabled: Bool {
        manager.isPreviousAvailable
    }
    
    private(set) var currentFlow: NavigationExperimentFlowType
    
    init(manager: ExperimentFlowManager, delegate: NavigationExperimentFlow) {
        self.manager = manager
        self.currentFlow = manager.currentFlow
        self.delegate = delegate
    }
    
    func load() {
        delegate?.start()
    }
    
    func moveNext() {
        currentFlow = manager.moveNext()
        delegate?.moveNext()
    }
    
    func movePrevious() {
        currentFlow = manager.movePrevious()
        delegate?.movePrevious()
    }
}
