//
//  APNSManager.swift
//  ApplicationLifeCycleUIKIt
//
//  Created by mohit.dubey on 17/05/23.
//

import Foundation
import UserNotifications
import UIKit

//Send notification command -> xcrun simctl push <Device_Identifier> <Bundle_Identifier> <FileName>.apn
class APNSManager {
    struct NotificationMeta {
        var title: String
        var identifier: String
        var date: Date
    }
    
    enum NotificationPermissionStatus {
        case neverAsked
        case denied
        case granted
    }
    
    let service: APNSService
    private(set) var deviceToken: Data?
    static let shared = APNSManager(service: APNSService())
    
    private init(service: APNSService) {
        self.service = service
        registerRemoteNotification()
        registerForActionables()
    }

    func registerRemoteNotification() {
        service.getNotificationSettings {[weak self] status in
            switch status {
                case .neverAsked:
                    self?.service.requestForNotification { granted, error in
                        if granted {
                            self?.registerForRemoteNotificationDeviceToken()
                        }
                    }
                case .denied:
                    let _ = Task.init {
                        await UIApplication.shared.openAppNotificationSettings()
                    }
            
                case .granted:
                    self?.registerForRemoteNotificationDeviceToken()
            }
        }
    }
    
    private func registerForRemoteNotificationDeviceToken() {
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func updateDeviceToken(token: Data) {
        deviceToken = token
        
        if let tokenParts = deviceToken?.map( { data in String(format: "%02.2hhx", data as CVarArg) }) {
            let token = tokenParts.joined()
            print("Device Token: \(token)")
            
            registerForActionables()
        }

    }
    
    private func registerForActionables() {
            // 1
        let viewAction = UNNotificationAction(
            identifier: APNSActionIdentifiers.viewAction,
            title: "View notification",
            options: [.foreground])
        
            // 2
        let firstCategory = UNNotificationCategory(
            identifier: APNSActionIdentifiers.firstCategory,
            actions: [viewAction],
            intentIdentifiers: [],
            options: [])
        
            // 3
        UNUserNotificationCenter.current().setNotificationCategories([firstCategory])
    }
}
