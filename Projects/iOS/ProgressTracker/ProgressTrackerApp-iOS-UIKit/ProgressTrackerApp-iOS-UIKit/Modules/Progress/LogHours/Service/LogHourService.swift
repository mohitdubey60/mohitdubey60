//
//  LogHourService.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 17/02/23.
//

import Foundation

protocol GHourlyDayTable {
    var sd: Date? {get}
    var ed: Date? {get}
    var fd: Date? {get}
    var d: String? {get}
    var diffInMinutes: Int {get}
}

protocol SaveLogHoursService {
    func saveDayHourLogs(forDate date: Date, startDate: Date, endDate: Date, days: [String]) throws -> Bool
}

protocol GetLogHoursService {
    func getAllDaysHourLogs() throws -> [String: [GHourlyDayTable]]
    func getHourLogs(forDay day: String) throws -> [GHourlyDayTable]
}

protocol LogHourService: SaveLogHoursService, GetLogHoursService {
    
}

extension HourlyDayTable: GHourlyDayTable {
    var sd: Date? {
        startDateTime
    }
    
    var ed: Date? {
        endDateTime
    }
    
    var fd: Date? {
        forDate
    }
    
    var d: String? {
        day
    }
    
    var diffInMinutes: Int {
        if let edt = endDateTime, let sdt = startDateTime {
            let result: (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) =  edt - sdt
            return result.minute ?? 0
        }
        
        return 0
    }
}

extension Sequence where Element == GHourlyDayTable {
    var totalLog: Int {
        map({ $0.diffInMinutes }).reduce(.zero, +)
    }
    
    var minLog: Int {
        map({ $0.diffInMinutes }).reduce(.zero, { Swift.min($0, $1) })
    }
    
    var maxLog: Int {
        map({ $0.diffInMinutes }).reduce(.zero, { Swift.max($0, $1) })
    }
}
