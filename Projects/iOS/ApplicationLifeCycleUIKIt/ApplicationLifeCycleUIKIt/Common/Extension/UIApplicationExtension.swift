//
//  UIApplicationExtension.swift
//  ApplicationLifeCycleUIKIt
//
//  Created by mohit.dubey on 17/05/23.
//

import UIKit

extension UIApplication {
    private static let notificationSettingsURLString: String? = {
        if #available(iOS 16, *) {
            return UIApplication.openNotificationSettingsURLString
        }
        
        if #available(iOS 15.4, *) {
            return UIApplicationOpenNotificationSettingsURLString
        }
        
        if #available(iOS 8.0, *) {
                // just opens settings
            return UIApplication.openSettingsURLString
        }
        
            // lol bruh
        return nil
    }()
    
    private static let appNotificationSettingsURL = URL(
        string: notificationSettingsURLString ?? ""
    )
    
    func openAppNotificationSettings() async -> Bool {
        guard
            let url = UIApplication.appNotificationSettingsURL,
            self.canOpenURL(url) else { return false }
        return await self.open(url)
    }
}
