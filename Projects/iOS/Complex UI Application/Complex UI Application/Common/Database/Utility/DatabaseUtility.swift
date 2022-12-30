    //
    //  DatabaseUtility.swift
    //  Complex UI Application
    //
    //  Created by mohit.dubey on 16/08/22.
    //

import UIKit
import CoreData
import Combine

class CoreDataDatabaseUtility {
    private lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: dbName)
        container.loadPersistentStores { store, error in
            if let err = error {
                fatalError("Error with container \(err)")
            }
        }
        return container
    }()
    
    private(set) var managedContext: NSManagedObjectContext?
    private let dbName: String
    
    init(dbName: String) {
        self.dbName = dbName
        createData()
    }
    
    func createData() {
        managedContext = persistantContainer.viewContext
        Swift.print("Mohit: DB file location \(persistantContainer.persistentStoreDescriptions.first?.url?.absoluteString ?? "")")
    }
    
    func retrieveAllData<T: NSManagedObject>(predicate: NSPredicate?) -> Future<[T], Error> {
        return Future<[T], Error> {[weak self] promise in
            guard let `self` = self else {
                return promise(.failure(DatabaseError.bahutJagahHai))
            }
            
            do {
                Swift.print("Mohit: Describing \(String(describing: T.self))")
                let fetchRequest = T.fetchRequest()
                fetchRequest.predicate = predicate
                if let fetchResult = try self.managedContext?.fetch(fetchRequest) as? [T] {
                    return promise(.success(fetchResult))
                }
                return promise(.success([]))
            } catch {
                promise(.failure(error))
            }
            
            return promise(.failure(DatabaseError.nahiJagahHai))
        }
    }
    
    func retrieveAllData<T: NSManagedObject>(predicate: NSPredicate?) async throws -> [T] {
        let task = Task {[weak self] () throws -> [T] in
            guard let `self` = self else {
                throw DatabaseError.bahutJagahHai
            }
            do {
                Swift.print("Mohit: Describing \(String(describing: T.self))")
                let fetchRequest = T.fetchRequest()
                fetchRequest.predicate = predicate
                if let fetchResult = try self.managedContext?.fetch(fetchRequest) as? [T] {
                    return fetchResult
                }
                return []
            } catch {
                throw error
            }
        }
        
        return try await task.value
    }
    
    func deleteData<T: NSManagedObject>(type: T.Type = T.self, predicate: NSPredicate?) throws -> Int {
        do {
            let fetchRequest = T.fetchRequest()
            fetchRequest.predicate = predicate
            let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            if let _ = try managedContext?.execute(batchDelete) {
                return 1
            }
            return 0
        } catch {
            throw error
        }
    }
}
