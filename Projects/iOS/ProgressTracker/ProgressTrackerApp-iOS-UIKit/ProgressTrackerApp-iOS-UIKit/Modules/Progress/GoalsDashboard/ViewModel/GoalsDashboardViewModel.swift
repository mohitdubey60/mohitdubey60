    //
    //  GoalsDashboardViewModel.swift
    //  ProgressTrackerApp-iOS-UIKit
    //
    //  Created by mohit.dubey on 25/02/23.
    //

import Foundation

class GoalsDashboardViewModel {
    var days: [DaysOfWeek] = DaysOfWeek.allCases
    let logHoursManager: LogHoursManager
    
    var expectedLogForEachDay: [String: Int] = [:]
    
    init(days: [DaysOfWeek] = DaysOfWeek.allCases) {
        logHoursManager = LogManagerFactory.logHoursManager
        self.days = days
        
        updateExpectedLogsForEachDay()
    }
    
    func updateExpectedLogsForEachDay() {
        let dayLogs = logHoursManager.getLatestLogForEachDay()
        for (key, value) in dayLogs {
            let sum: Int = value.totalLog
            expectedLogForEachDay[key] = sum
        }
    }
}
