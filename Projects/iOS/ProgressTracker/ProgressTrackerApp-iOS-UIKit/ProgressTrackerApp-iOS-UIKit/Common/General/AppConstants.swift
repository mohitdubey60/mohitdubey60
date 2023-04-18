//
//  AppConstants.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 17/02/23.
//

import UIKit
import CoreData

enum PersistentStorage {
    case coreData
}
struct AppConstants {
    static var coreDataContext: NSManagedObjectContext? {
        get {
            if Thread.isMainThread {
                return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            } else {
                return DispatchQueue.main.sync {
                    return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
                }
            }
        }
    }
    
    static var persistentStorage: PersistentStorage {
        .coreData
    }
}
