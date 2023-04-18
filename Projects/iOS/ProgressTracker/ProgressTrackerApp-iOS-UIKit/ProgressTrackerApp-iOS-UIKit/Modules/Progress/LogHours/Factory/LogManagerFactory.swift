//
//  LogManagerFactory.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 21/02/23.
//

import Foundation

class LogManagerFactory {
    static var logHoursManager: LogHoursManager {
        switch(AppConstants.persistentStorage) {
            case .coreData:
                return LogHoursManager(logHourService: CoreDataLogHourService())
        }
    }
}
