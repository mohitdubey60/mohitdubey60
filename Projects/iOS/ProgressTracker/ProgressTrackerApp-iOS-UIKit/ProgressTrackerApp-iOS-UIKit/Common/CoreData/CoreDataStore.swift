//
//  CoreDataStore.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 27/02/23.
//

import Foundation
import CoreData

typealias Action = (()->())
enum StorageType {
    case persistent, inMemory
}

protocol EntityCreating {
    var viewContext: NSManagedObjectContext { get }
    func createEntity<T: NSManagedObject>() -> T
}
extension EntityCreating {
    func createEntity<T: NSManagedObject>() -> T {
        return T(context: viewContext)
    }
}

protocol CoreDataAddPublishing {
    var viewContext: NSManagedObjectContext { get }
    func publisher(add action: @escaping Action) -> CoreDataAddPublisher
}
extension CoreDataAddPublishing {
    func publisher(add action: @escaping Action) -> CoreDataAddPublisher {
        return CoreDataAddPublisher(action: action, context: viewContext)
    }
}

protocol CoreDataDeletePublishing {
    var viewContext: NSManagedObjectContext { get }
    func publisher(delete request: NSFetchRequest<NSFetchRequestResult>) -> CoreDataDeletePublisher
}
extension CoreDataDeletePublishing {
    func publisher(delete request: NSFetchRequest<NSFetchRequestResult>) -> CoreDataDeletePublisher {
        return CoreDataDeletePublisher(delete: request, context: viewContext)
    }
}

protocol CoreDataFetchResultsPublishing {
    var viewContext: NSManagedObjectContext { get }
    func publisher<T: NSManagedObject>(fetch request: NSFetchRequest<T>) -> CoreDataFetchResultPublisher<T>
}
extension CoreDataFetchResultsPublishing {
    func publisher<T: NSManagedObject>(fetch request: NSFetchRequest<T>) -> CoreDataFetchResultPublisher<T> {
        return CoreDataFetchResultPublisher(request: request, context: viewContext)
    }
}

protocol CoreDataStoring: EntityCreating, CoreDataFetchResultsPublishing, CoreDataDeletePublishing, CoreDataAddPublishing {
    var viewContext: NSManagedObjectContext { get }
}

class CoreDataStore: CoreDataStoring {
    private let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        get {
            return self.container.viewContext
        }
    }
    
    static var `default`: CoreDataStoring = {
        return CoreDataStore(name: "progressTracker", in: .persistent)
    }()
    
    init(name: String, in storageType: StorageType) {
        self.container = NSPersistentContainer(name: name)
        self.setupIfMemoryStorage(storageType)
        self.container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    private func setupIfMemoryStorage(_ storageType: StorageType) {
        if storageType  == .inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            self.container.persistentStoreDescriptions = [description]
        }
    }
}
