//
//  ProgressTrackerDatabaseUtility.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 16/08/22.
//

import Foundation
import Combine
import CoreData

struct LocalTimeSlot {
    let dayName: String, startTime: Int64, endTime: Int64, startDate: Int64
}
enum DatabaseError: Error {
    case nahiJagahHai
    case bahutJagahHai
}

class ProgressTrackerDatabaseUtility: CoreDataDatabaseUtility {
    static let shared: ProgressTrackerDatabaseUtility = ProgressTrackerDatabaseUtility()
    
    private init() {
        super.init(dbName: ProgressConstants.databaseName)
    }
    
    func saveTimeSlot(timeSlot slot: LocalTimeSlot) -> Future<Bool, Error> {
        return Future<Bool, Error> {[weak self] promise in
            guard let `self` = self else {
                return promise(.failure(DatabaseError.bahutJagahHai))
            }
            
            if let mc = self.managedContext {
                let timeSlot = TimeSlot(context: mc)
                timeSlot.dayName = slot.dayName
                timeSlot.endTime = slot.endTime
                timeSlot.startTime = slot.startTime
                
                do {
                    try mc.save()
                    promise(.success(true))
                } catch{
                    return promise(.failure(error))
                }
            }
            
            return promise(.failure(DatabaseError.nahiJagahHai))
        }
    }
    
    
    func saveTimeSlot(timeSlot slot: LocalTimeSlot) async throws -> Bool {
        let insertTask = Task {[weak self] () throws -> Bool in
            guard let `self` = self else {
                throw DatabaseError.bahutJagahHai
            }
            
            if let mc = self.managedContext {
                let timeSlot = TimeSlot(context: mc)
                timeSlot.dayName = slot.dayName
                timeSlot.endTime = slot.endTime
                timeSlot.startTime = slot.startTime
                
                do {
                    try mc.save()
                    return true
                } catch{
                    throw error
                }
            }
            
            throw DatabaseError.nahiJagahHai
        }
        
        do {
            return try await insertTask.value
        } catch {
            throw error
        }
    }
    
    func saveTimeSlots(timeSlots slots: [LocalTimeSlot]) async throws -> Bool {
        let insertTask = Task {[weak self] () throws -> Bool in
            guard let `self` = self else {
                throw DatabaseError.bahutJagahHai
            }
            var value = false
            for item in slots {
                do {
                    value = try await self.saveTimeSlot(timeSlot: item)
                } catch {
                    throw error
                }
            }
            return value
        }
        
        do {
            return try await insertTask.value
        } catch {
            throw error
        }
    }
}
