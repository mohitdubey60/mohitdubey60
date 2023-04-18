//
//  DateExtension.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 17/02/23.
//

import Foundation

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func dateToHHmm() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let currentTime = formatter.string(from: self)
        return currentTime
    }
    func dateToDDMMMYYYY() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        let currentTime = formatter.string(from: self)
        return currentTime
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSince1970 - rhs.timeIntervalSince1970
    }
    
    static func - (lhs: Date, rhs: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: rhs, to: lhs).day
        let month = Calendar.current.dateComponents([.month], from: rhs, to: lhs).month
        let hour = Calendar.current.dateComponents([.hour], from: rhs, to: lhs).hour
        let minute = Calendar.current.dateComponents([.minute], from: rhs, to: lhs).minute
        let second = Calendar.current.dateComponents([.second], from: rhs, to: lhs).second
        
        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }
    
    func getDatesOfWeek() -> [String : Date] {
        var datesDictionary: [String: Date] = [:]
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dayOfWeek = calendar.component(.weekday, from: today)
        if let dates = calendar.range(of: .weekday, in: .weekOfYear, for: today)?
            .compactMap({ calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }) {
            for date in dates {
                datesDictionary[date.dayOfWeek() ?? ""] = date
            }
        }
        return datesDictionary
    }
}

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var startOfWeek: Date {
        Calendar.current.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
    
    var endOfWeek: Date {
        var components = DateComponents()
        components.weekOfYear = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfWeek)!
    }
    
    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: components)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }
}
