//
//  CoreDataAddPublisher.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 27/02/23.
//

import Foundation
import Combine
import CoreData

struct CoreDataAddPublisher: Publisher {

    typealias Output = Bool
    typealias Failure = NSError
    
    private let action: Action
    private let context: NSManagedObjectContext
    
    init(action: @escaping Action, context: NSManagedObjectContext) {
        self.action = action
        self.context = context
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, NSError == S.Failure, Bool == S.Input {
        let subscription = Subscription(subscriber: subscriber, context: context, action: action)
        subscriber.receive(subscription: subscription)
    }
}

extension CoreDataAddPublisher {
    class Subscription<S> where S : Subscriber, Failure == S.Failure, Output == S.Input {
        private var subscriber: S?
        private let action: Action
        private let context: NSManagedObjectContext
        
        init(subscriber: S, context: NSManagedObjectContext, action: @escaping Action) {
            self.subscriber = subscriber
            self.context = context
            self.action = action
        }
    }
}

extension CoreDataAddPublisher.Subscription: Subscription {
    func request(_ demand: Subscribers.Demand) {
        var demand = demand
        guard let subscriber = subscriber, demand > 0 else { return }
        
        do {
            action()
            demand -= 1
            try context.save()
            demand += subscriber.receive(true)
        } catch {
            subscriber.receive(completion: .failure(error as NSError))
        }
    }
}

extension CoreDataAddPublisher.Subscription: Cancellable {
    func cancel() {
        subscriber = nil
    }
}
