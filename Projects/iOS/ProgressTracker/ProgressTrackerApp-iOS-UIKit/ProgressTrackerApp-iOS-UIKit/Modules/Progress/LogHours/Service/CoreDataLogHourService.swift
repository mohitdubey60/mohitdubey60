//
//  CoreDataLogHourService.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 17/02/23.
//

import Foundation
import CoreData

enum CoreDataErrors: Error {
    case noDaysSelected
    case coreDataViewContextMissing
}
extension CoreDataErrors: CustomStringConvertible {
    public var description: String {
        switch self {
            case .noDaysSelected:
                return "Days are sent as zero"
            case .coreDataViewContextMissing:
                return "Cannot instantiate coreDataContext"
        }
    }
}

extension CoreDataErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .noDaysSelected:
                return "Days are sent as zero"
            case .coreDataViewContextMissing:
                return "Cannot instantiate coreDataContext"
        }
    }
}

protocol ICoreDataGetLogHoursService: GetLogHoursService {
    
}
extension ICoreDataGetLogHoursService {
    func getAllDaysHourLogs() throws -> [String: [GHourlyDayTable]] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: HourlyDayTable.className)
        
        let sort = NSSortDescriptor(key: "startDateTime", ascending: true)
        request.sortDescriptors = [sort]
        
        if let context = AppConstants.coreDataContext {
            do {
                if let result = try context.fetch(request) as? [HourlyDayTable] {
                    let groupedByDays = Dictionary(grouping: result, by: { $0.day?.uppercased() ?? "" })
                    return groupedByDays
                }
            } catch let err {
                throw err
            }
        }
        return [:]
    }
    
    func getHourLogs(forDay day: String) throws -> [GHourlyDayTable] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: HourlyDayTable.className)
        request.predicate = NSPredicate(format: "day=%@ and forDate==max(forDate)", day)
        
        let sort = NSSortDescriptor(key: "startDateTime", ascending: true)
        request.sortDescriptors = [sort]
        
        if let context = AppConstants.coreDataContext {
            do {
                if let result = try context.fetch(request) as? [HourlyDayTable] {
                    return result
                }
            } catch let err {
                throw err
            }
        }
        return []
    }
}

protocol ICoreDataSaveLogHoursService: SaveLogHoursService {
    
}
extension ICoreDataSaveLogHoursService {
    func saveDayHourLogs(forDate date: Date, startDate: Date, endDate: Date, days: [String]) throws -> Bool {
        if days.count == 0 {
            throw CoreDataErrors.noDaysSelected
        }
        
        if let context = AppConstants.coreDataContext {
            for day in days {
                let hourlyTable = HourlyDayTable(context: context)
                hourlyTable.startDateTime = startDate
                hourlyTable.endDateTime = endDate
                hourlyTable.forDate = date.startOfDay
                hourlyTable.day = day
            }
            
            do {
                try context.save()
            } catch let err {
                throw err
            }
            
            return true
        }
        
        throw CoreDataErrors.coreDataViewContextMissing
    }
}

class CoreDataGetLogHoursService: ICoreDataGetLogHoursService {
    
}
class CoreDataSaveLogHoursService: ICoreDataSaveLogHoursService {
    
}
class CoreDataLogHourService: LogHourService, ICoreDataGetLogHoursService, ICoreDataSaveLogHoursService {

}
