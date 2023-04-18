    //
    //  SetProgressHoursViewModel.swift
    //  ProgressTrackerApp-iOS-UIKit
    //
    //  Created by mohit.dubey on 15/02/23.
    //

import UIKit
import CoreData

protocol DayLogsObserver: AnyObject {
    func daysUpdated()
}

class SetProgressHoursViewModel {
    var days: [DaysOfWeek] = DaysOfWeek.allCases
    var selectedDays: [DaysOfWeek] = []
    var dayLogs: [String: [GHourlyDayTable]] = [:] {
        didSet {
            delegate?.daysUpdated()
        }
    }
    let logHoursManager: LogHoursManager
    weak var delegate: DayLogsObserver?
    weak var coordinator: SetProgressHoursDestinations?
    
    func collectionViewAllSelectedItems(indexes: [IndexPath]) -> Bool {
        if indexes.count > 0 {
            self.selectedDays = indexes.map { indexPath in
                days[indexPath.item]
            }
            return true
        } else {
            self.selectedDays = []
            return false
        }
    }
    
    private func checkForValidTime(startTime: Date, endTime: Date) -> Bool {
        return (startTime < endTime)
    }
    
    init(days: [DaysOfWeek], selectedDays: [DaysOfWeek], logHoursManager: LogHoursManager) {
        self.logHoursManager = logHoursManager
        self.days = days
        self.selectedDays = selectedDays
        DispatchQueue.global().async {[weak self] in
            self?.fetchResults()
        }
    }
    init(delegate: DayLogsObserver?, coordinator: SetProgressHoursDestinations?, logHoursManager: LogHoursManager) {
        self.delegate = delegate
        self.coordinator = coordinator
        self.logHoursManager = logHoursManager
        DispatchQueue.global().async {[weak self] in
            self?.fetchResults()
        }
    }
    
    init(logHoursManager: LogHoursManager) {
        self.logHoursManager = logHoursManager
        DispatchQueue.global().async {[weak self] in
            self?.fetchResults()
        }
    }
    
    func addSelectedDays(startDateTime: Date, endDateTime: Date, completion: @escaping (Bool, String) -> Void) {
        if !checkForValidTime(startTime: startDateTime, endTime: endDateTime) {
            completion(false, "Incorrect time selected!")
            return
        }
        
        let result = logHoursManager.saveDayHourLogs(startDate: startDateTime, endDate: endDateTime, days: selectedDays.compactMap{ $0.rawValue })
        if result {
            completion(result, "Records saved successfully!")
            fetchResults()
            return
        }
        
        
        completion(false, "Something went wrong in saving the details, please check logs!")
    }
    
    func fetchResults() {
        let result = logHoursManager.getDaysLogs()
        dayLogs = result
    }
    
    func fetchDayResults(day: String) {
        let result = logHoursManager.getDayLogs(forDay: day)
    }
}
