//
//  UserDefaultsFactory.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 11/07/23.
//

import Foundation

enum UserDefaultTypes: String, CaseIterable {
    case standard
    case pStandard
}

class UserDefaultsFactory {
    private var userDefaults: [String : UserDefaults] = [:]
    
    init() {
        for uDefault in UserDefaultTypes.allCases {
            getUserDefaults(for: uDefault)
        }
    }
    
    @discardableResult func getUserDefaults(for defaultType: UserDefaultTypes) -> UserDefaults? {
        switch defaultType {
            case .standard:
                if let uDefaults = userDefaults[defaultType.rawValue] {
                    return uDefaults
                } else {
                    userDefaults[defaultType.rawValue] = UserDefaults.standard
                    return UserDefaults.standard
                }
            default:
                if let uDefaults = userDefaults[defaultType.rawValue] {
                    return uDefaults
                } else if let newSuite = UserDefaults(suiteName: defaultType.rawValue) {
                    userDefaults[defaultType.rawValue] = newSuite
                    return newSuite
                }
        }
        
        return nil
    }
}
