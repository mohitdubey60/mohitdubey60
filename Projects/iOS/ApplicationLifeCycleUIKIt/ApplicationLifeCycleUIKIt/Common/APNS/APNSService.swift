    //
    //  APNSService.swift
    //  ApplicationLifeCycleUIKIt
    //
    //  Created by mohit.dubey on 17/05/23.
    //

import Foundation
import UserNotifications
import UIKit

class APNSService {
        //"UIApplication.shared.currentUserNotificationSettings" is depricated but still works
    var notificationPermissionGranted: Bool {
        if let type = UIApplication.shared.currentUserNotificationSettings?.types, type != [] {
            return true
        }
        
        return false
    }
    
        //Get the list of notification authorised category. For eg: badge, sound, alert, provisional, etc
    func getNotificationCategories() {
        UNUserNotificationCenter.current().getNotificationCategories { categories in
            categories.forEach { category in
                Swift.print("Mohit: Category is \(category)")
            }
            Swift.print("Mohit: Category count is \(categories.count)")
        }
    }
    
        //This will help to get all the delivered notifications that are currently in the notificationCenter
    func getDeliveredNotifications(completion: @escaping ([APNSManager.NotificationMeta])->Void) {
        UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
            let notificationsMeta = notifications.compactMap { notification in
                return APNSManager.NotificationMeta(title: notification.request.content.title, identifier: notification.request.identifier, date: notification.date)
            }
            
            completion(notificationsMeta)
        }
    }
    
        //This will give the current settings for notifications. Eg:
        // notDetermined - User has never asked for notifications permission
        // denied - User has denied the notifications permission and now only way is to enable notifications from settings page
        // all Other cases - User has authorised the notification permission
    func getNotificationSettings(completion: @escaping (APNSManager.NotificationPermissionStatus)->Void) {
        UNUserNotificationCenter.current().getNotificationSettings {settings in
            switch settings.authorizationStatus {
                case .notDetermined:
                    completion(.neverAsked)
                case .denied:
                    completion(.denied)
                case .authorized:
                    completion(.granted)
                case .provisional:
                    completion(.neverAsked)
                case .ephemeral:
                    completion(.neverAsked)
                @unknown default:
                    completion(.neverAsked)
            }
        }
    }
    
        //Show notifications permission prompt in case of never asked - "notDetermined"
    func requestForNotification(completion: @escaping (Bool, Error?) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]) {[weak self] granted, error in
                guard let self else {
                    completion(false, nil)
                    return
                }
                if let err = error {
                    completion(false, err)
                    return
                }
                
                if granted {
                    self.getNotificationCategories()
                    completion(true, nil)
                }
            }
    }
}
