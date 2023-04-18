//
//  CoreDataFetchResultPublisher.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 27/02/23.
//

import Foundation
import Combine
import CoreData

struct CoreDataFetchResultPublisher<Entity>: Publisher where Entity: NSManagedObject {
    typealias Output = [Entity]
    typealias Failure = NSError
    
    private let request: NSFetchRequest<Entity>
    private let context: NSManagedObjectContext
    
    init(request: NSFetchRequest<Entity>, context: NSManagedObjectContext) {
        self.request = request
        self.context = context
    }
    
    
    func receive<S>(subscriber: S) where S : Subscriber, NSError == S.Failure, [Entity] == S.Input {
        let subscription = Subscription(subscriber: subscriber, context: context, request: request)
        subscriber.receive(subscription: subscription)
    }
}

extension CoreDataFetchResultPublisher {
    class Subscription<S> where S : Subscriber, Failure == S.Failure, Output == S.Input {
        private var subscriber: S?
        private var request: NSFetchRequest<Entity>
        private var context: NSManagedObjectContext
        
        init(subscriber: S, context: NSManagedObjectContext, request: NSFetchRequest<Entity>) {
            self.subscriber = subscriber
            self.context = context
            self.request = request
        }
    }
}

extension CoreDataFetchResultPublisher.Subscription: Subscription {
    func request(_ demand: Subscribers.Demand) {
        var demand = demand
        guard let subscriber = subscriber, demand > 0 else { return }
        do {
            demand -= 1
            let items = try context.fetch(request)
            demand += subscriber.receive(items)
        } catch {
            subscriber.receive(completion: .failure(error as NSError))
        }
    }
}

extension CoreDataFetchResultPublisher.Subscription: Cancellable {
    func cancel() {
        subscriber = nil
    }
}
