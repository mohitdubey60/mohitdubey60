//
//  UserDefaultsExtension.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 11/07/23.
//

import Foundation

extension UserDefaults {
    @objc var musicVolume: Float {
        get {
            float(forKey: "music_volume")
        } set {
            set(newValue, forKey: "music_volume")
        }
    }
}
