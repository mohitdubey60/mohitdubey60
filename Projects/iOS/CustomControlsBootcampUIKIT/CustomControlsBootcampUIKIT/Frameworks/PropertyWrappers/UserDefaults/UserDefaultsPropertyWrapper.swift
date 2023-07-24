    //
    //  UserDefaultsPropertyWrapper.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 11/07/23.
    //

import Foundation
import Combine

class CustomUserDefaults {
    static func initUserDefaults() {
        
    }
    
    private static let userDefaultsFactory = UserDefaultsFactory()
    private static func getUserDefaults(for type: UserDefaultTypes) -> UserDefaults? {
        userDefaultsFactory.getUserDefaults(for: type)
    }
    
    static var suite: UserDefaults? {
        userDefaultsFactory.getUserDefaults(for: .standard)
    }
    
    @UserDefaultsPropertyWrapper(defaultValue: false, key: #keyPath(isDarkMode))
    @objc static var isDarkMode: Bool
}

extension CustomUserDefaults {
    @propertyWrapper
    class UserDefaultsPropertyWrapper<T> {
//        @Published var value: T
        var defaultValue: T
        var key: String
        
        init(defaultValue: T, key: String) {
//            self.value = defaultValue
            self.defaultValue = defaultValue
            self.key = key
        }
        
        var wrappedValue: T {
            get {
                if let ud = CustomUserDefaults.getUserDefaults(for: .standard),
                   let _udValue = ud.object(forKey: key),
                   let udValue = _udValue as? T {
                    return udValue
                }
                
                return defaultValue
            }
            set {
                if let ud = CustomUserDefaults.getUserDefaults(for: .standard) {
                    ud.set(newValue, forKey: key)
//                    value = newValue
                }
            }
        }
        
        var projectedValue: (any Publisher)? {
            if #available(iOS 14.0, *), let ud = CustomUserDefaults.getUserDefaults(for: .standard)  {
                return ud.object(forKey: key).publisher
            }
            
            return nil
        }
        
//        var projectedValue: AnyPublisher<T, Never> {
//            return $value.eraseToAnyPublisher()
//        }
    }
}
