//
//  ExperimentUserDefaults.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 09/05/23.
//

import Foundation

struct ExperimentUserDefaultsKeys {
    static var languageScreen: String {
        "languageScreenExperimentKey"
    }
    static var profileScreen: String {
        "profileScreenExperimentKey"
    }
    static var interestScreen: String {
        "interestScreenExperimentKey"
    }
    static var feedScreen: String {
        "feedScreenExperimentKey"
    }
}

class ExperimentUserDefaults {
    @UserDefault<Bool>(key: ExperimentUserDefaultsKeys.languageScreen, defaultValue: true)
    static var showLanguageScreen: Bool
    @UserDefault<Bool>(key: ExperimentUserDefaultsKeys.profileScreen, defaultValue: true)
    static var showProfileScreen: Bool
    @UserDefault<Bool>(key: ExperimentUserDefaultsKeys.interestScreen, defaultValue: true)
    static var showInterestScreen: Bool
    @UserDefault<Bool>(key: ExperimentUserDefaultsKeys.feedScreen, defaultValue: true)
    static var showFeedScreen: Bool
}

extension ExperimentUserDefaults {
    @propertyWrapper
    struct UserDefault<T> {
        var key: String
        var defaultValue: T
        var wrappedValue: T {
            get {
                return UserDefaults.standard.value(forKey: key) as? T ?? defaultValue
            }
            set {
                let storage = UserDefaults.standard
                storage.set(newValue, forKey: key)
            }
        }
    }
}
