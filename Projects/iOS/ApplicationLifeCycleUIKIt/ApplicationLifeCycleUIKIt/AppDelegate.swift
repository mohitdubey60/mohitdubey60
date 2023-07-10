    //
    //  AppDelegate.swift
    //  ApplicationLifeCycleUIKIt
    //
    //  Created by mohit.dubey on 13/05/23.
    //

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
        UNUserNotificationCenter.current().delegate = self
        
        APNSManager.shared.registerRemoteNotification()
        Swift.print("Mohit: LaunchOptions \(launchOptions)")
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Swift.print("Mohit: Called willFinishLaunchingWithOptions:")
        return true
    }
    
        // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            // Called when a new scene session is being created.
            // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
            // Called when the user discards a scene session.
            // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
            // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        Swift.print("Mohit: applicationDidEnterBackground:")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        Swift.print("Mohit: applicationWillEnterForeground:")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        Swift.print("Mohit: applicationWillResignActive:")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        Swift.print("Mohit: applicationDidBecomeActive:")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        Swift.print("Mohit: applicationWillTerminate:")
    }
    
}

    //Notifications Implementation
extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        APNSManager.shared.updateDeviceToken(token: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Swift.print("Mohit: APNS Device token error \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Swift.print("Mohit: didReceiveRemoteNotification called \(userInfo)")
        guard let aps = userInfo["aps"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
        }
        Swift.print("Mohit: LaunchOptions \(aps)")
    }
    
        //This is called regardless of the app is running or closed. "Notification did tap"
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        Swift.print("Mohit: Received userNotificationCenter(_ center: UNUserNotificationCenter, willPresent")
        Swift.print("Mohit: LaunchOptions \(notification)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        Swift.print("Mohit: Notifications didReceive \(response.notification.request.content.userInfo)")
        
        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            Swift.print("Mohit: Current window is \(keyWindow.rootViewController)")
            
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationsActionViewController") as? NotificationsActionViewController,
               let nvc = keyWindow.rootViewController as? UINavigationController {
                nvc.pushViewController(vc, animated: true)
            }
        }
        
        if response.actionIdentifier == APNSActionIdentifiers.viewAction {
            Swift.print("Mohit: Clicked on action \(response.actionIdentifier)")
        }
    }
}

extension AppDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
}
