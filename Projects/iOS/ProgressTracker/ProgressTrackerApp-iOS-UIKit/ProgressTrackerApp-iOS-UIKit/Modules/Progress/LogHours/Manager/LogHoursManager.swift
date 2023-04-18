//
//  LogHoursManager.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 15/02/23.
//

import Foundation
import CoreData

protocol IGetLogHoursManager {
    var getLogHourService: GetLogHoursService { get }
    
    func getDaysLogs() -> [String: [GHourlyDayTable]]
    func getDayLogs(forDay day: String) -> [GHourlyDayTable]
    func getLatestLogForEachDay() -> [String: [GHourlyDayTable]]
}
extension IGetLogHoursManager {
    func getDaysLogs() -> [String: [GHourlyDayTable]] {
        do {
            let result = try getLogHourService.getAllDaysHourLogs()
            return result
        } catch let err {
            Swift.print("Mohit: Error in fetching the grouped days log \(err.localizedDescription)")
            return [:]
        }
    }
    
    func getDayLogs(forDay day: String) -> [GHourlyDayTable] {
        do {
            let result = try getLogHourService.getHourLogs(forDay: day)
            return result
        } catch let err {
            Swift.print("Mohit: Error in fetching the grouped days log \(err.localizedDescription)")
            return []
        }
    }
    
    func getLatestLogForEachDay() -> [String: [GHourlyDayTable]] {
        var daysDictionary: [String: [GHourlyDayTable]] = [:]
        for day in DaysOfWeek.allCases {
            do {
                let result = try getLogHourService.getHourLogs(forDay: day.rawValue)
                daysDictionary[day.rawValue] = result
            } catch let err {
                Swift.print("Mohit: Error in fetching the logs for \(day.rawValue) -> \(err.localizedDescription)")
            }
        }
        
        return daysDictionary
    }
}

protocol ISaveLogHoursManager {
    var saveLogHourService: SaveLogHoursService { get }
    func saveDayHourLogs(startDate: Date, endDate: Date, days: [String]) -> Bool
}
extension ISaveLogHoursManager {
    func saveDayHourLogs(startDate: Date, endDate: Date, days: [String]) -> Bool {
        do {
            return try saveLogHourService.saveDayHourLogs(forDate: startDate, startDate: startDate, endDate: endDate, days: days)
        } catch let err {
            Swift.print("Mohit: Error in saving data -> \(err.localizedDescription)")
            return false
        }
    }
}

class LogHoursManager: IGetLogHoursManager, ISaveLogHoursManager {
    internal var getLogHourService: GetLogHoursService
    internal var saveLogHourService: SaveLogHoursService
        
    private var totalLogHours: Int = 0
    
    init(logHourService: LogHourService) {
        getLogHourService = logHourService
        saveLogHourService = logHourService
    }
    
    func checkForValidTime(startTime: Date, endTime: Date) -> Bool {
        return (startTime < endTime)
    }
    
    func areLogsAvailable() -> Bool {
        if totalLogHours != 0 {
            return true
        }
        
        totalLogHours = getDaysLogs().flatMap { (key: String, value: [GHourlyDayTable]) in
            value
        }.totalLog
        
        return totalLogHours > 0
    }
}
