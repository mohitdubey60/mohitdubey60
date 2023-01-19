//
//  Atomic.swift
//  RickAndMortyGraphQL
//
//  Created by mohit.dubey on 18/01/23.
//

//Reference code: https://www.onswiftwings.com/posts/atomic-property-wrapper/
import Foundation

@propertyWrapper
struct atomic<Value> {
    
    private var value: Value
    private let lock = NSLock()
    
    init(wrappedValue value: Value) {
        self.value = value
    }
    
    var wrappedValue: Value {
        get { return load() }
        set { store(newValue: newValue) }
    }
    
    func load() -> Value {
        lock.lock()
        defer { lock.unlock() }
        return value
    }
    
    mutating func store(newValue: Value) {
        lock.lock()
        defer { lock.unlock() }
        value = newValue
    }
}

