//
//  DateExtension.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 18/08/22.
//

import Foundation

extension Date {
    static func checkIfTimeSelectionIsValid(startTimeDate start: Date, endTimeDate end: Date) -> Bool {
        return start < end
    }
    
    static func checkIfTimeSelectionIsValid(startTimeDate start: Date, endTimeDate end: Date,
                                     timeToCheckStart currentStart: Date, timeToCheckEnd currentEnd: Date) -> Bool {
        if checkIfTimeSelectionIsValid(startTimeDate: currentStart, endTimeDate: currentEnd) {
            if currentStart >= end {
                return true
            }
            if currentEnd <= start {
                return true
            }
        }
        
        return false
    }
    
    static func diffInMinutes(startTimeInterval: Int, endTimeInterval: Int) -> Int? {
        let startDate: Date = Date(timeIntervalSince1970: TimeInterval(startTimeInterval))
        let endDate: Date = Date(timeIntervalSince1970: TimeInterval(endTimeInterval))
        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute], from: startDate)
        let nowComponents = calendar.dateComponents([.hour, .minute], from: endDate)
        
        let difference = calendar.dateComponents([.minute], from: timeComponents, to: nowComponents).minute!
        return difference
    }
    
    var currentTime: String {
        get {
            let calendar = Calendar.current
            return "\(calendar.component(.hour, from: self)):\(calendar.component(.minute, from: self))"
        }
    }
}
