//
//  LocalPushNotifications.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 20/12/22.
//

import Foundation
import UserNotifications
import CoreLocation

class LocalPushNotificationManager {
    static let shared = LocalPushNotificationManager()
    private init() {}
    
    private func requestAuthorization(completionHandler: @escaping (Bool) -> Void) {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Access error \(error.localizedDescription)")
                completionHandler(false)
                return
            }
            
           completionHandler(success)
        }
    }
    
    private func sendNotificationToUser(_ title: String, _ subTitle: String) {
        let content = UNMutableNotificationContent()
        content.sound = .default
        content.badge = 1
        content.title = title
        content.subtitle = subTitle
        
        //Time notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        //Calendar notification
        //        var dateComponent = DateComponents()
        //        dateComponent.hour = 14    // Hour of the day
        //        dateComponent.minute = 30  // Minute of the day
        //
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
    
        //Location notification
        //        let coordinates = CLLocationCoordinate2D(latitude: 12.931360, longitude: 77.693560)
        //        let region = CLCircularRegion(center: coordinates,
        //                                      radius: 100,
        //                                      identifier: UUID().uuidString)
        //        region.notifyOnEntry = true
        //        region.notifyOnEntry = false
        //        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func sendNotification(title: String, subTitle: String) {
        requestAuthorization {[weak self] isAllowed in
            if isAllowed {
                self?.sendNotificationToUser(title, subTitle)
            }
        }
    }
}
