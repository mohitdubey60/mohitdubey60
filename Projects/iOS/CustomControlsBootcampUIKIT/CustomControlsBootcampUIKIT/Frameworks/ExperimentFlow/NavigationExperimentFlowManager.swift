    //
    //  ExperimentFlowManager.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 09/05/23.
    //

import Foundation

protocol ExperimentFlowManager {
    var flow: [NavigationExperimentFlowType] { get }
    var currentFlow: NavigationExperimentFlowType { get }
    var isPreviousAvailable: Bool { get }
    var isNextAvailable: Bool { get }
    func generateFlow()
    func moveNext() -> NavigationExperimentFlowType
    func movePrevious() -> NavigationExperimentFlowType
}

class BaseExperimentFlowManager {
    var _flow: [NavigationExperimentFlowType]
    var _currentFlow: NavigationExperimentFlowType
    var isPreviousAvailable: Bool {
        if let index = _flow.firstIndex(of: _currentFlow), index - 1 > -1 {
            return true
        }
        
        return false
    }
    var isNextAvailable: Bool {
        if let index = _flow.firstIndex(of: _currentFlow), index > -1, index + 1 < _flow.count {
            return true
        }
        
        return false
    }
    
    init(flow: [NavigationExperimentFlowType]) {
        self._flow = flow
        self._currentFlow = flow.first ?? .feed
    }
    
    func moveNext() -> NavigationExperimentFlowType {
        if isNextAvailable, let index = _flow.firstIndex(of: _currentFlow) {
            print("Move to \(_flow[index + 1])")
            _currentFlow = _flow[index + 1]
        } else {
            print("Reached end of Screens")
        }
        return _currentFlow
    }
    
    func movePrevious() -> NavigationExperimentFlowType {
        if isPreviousAvailable, let index = _flow.firstIndex(of: _currentFlow) {
            print("Move to \(_flow[index - 1])")
            _currentFlow = _flow[index - 1]
        } else {
            print("Reached start of Screens")
        }
        return _currentFlow
    }
}

class OnboardingExperimentFlowManager: BaseExperimentFlowManager, ExperimentFlowManager {
    var flow: [NavigationExperimentFlowType] {
        _flow
    }
    
    var currentFlow: NavigationExperimentFlowType {
        _currentFlow
    }
    
    override init(flow: [NavigationExperimentFlowType]) {
        super.init(flow: flow)
        
        generateFlow()
        self._currentFlow = flow.first ?? .feed
    }
    
    func generateFlow() {
        var tempFlow: [NavigationExperimentFlowType] = []
        
        for currentFlow in _flow {
            switch currentFlow {
                case .language:
                    if ExperimentUserDefaults.showLanguageScreen {
                        tempFlow.append(currentFlow)
                    }
                case .profile:
                    if ExperimentUserDefaults.showProfileScreen {
                        tempFlow.append(currentFlow)
                    }
                case .interest:
                    if ExperimentUserDefaults.showInterestScreen {
                        tempFlow.append(currentFlow)
                    }
                case .feed:
                    if ExperimentUserDefaults.showFeedScreen {
                        tempFlow.append(currentFlow)
                    }
            }
        }
        
        self._flow = tempFlow
        if !_flow.contains(.feed) {
            _flow.append(.feed)
        }
        _currentFlow = _flow.first ?? .feed
    }
}
