//
//  GoalsDashboardManager.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 28/02/23.
//

import Foundation

class GoalsDashboardManager {
    var getLogHourService: GetLogHoursService
    
    init(getLogHourService: GetLogHoursService) {
        self.getLogHourService = getLogHourService
    }
}

extension GoalsDashboardManager: IGetLogHoursManager {
}
