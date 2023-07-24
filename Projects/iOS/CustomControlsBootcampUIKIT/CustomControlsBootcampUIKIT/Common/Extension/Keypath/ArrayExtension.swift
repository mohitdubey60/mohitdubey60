//
//  ArrayExtension.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 17/07/23.
//

import Foundation

extension Array {
    func map<T>(_ keypath: KeyPath<Element, T>) -> [T] {
        return map { $0[keyPath: keypath] }
    }
    
    func average<T: Numeric>(_ keypath: KeyPath<Element, T>) -> Double {
        var count: Double = 0
        var sum: Double = .zero
        
        forEach {
            var d: Double = 0
            switch $0[keyPath: keypath] {
                case let ii as Int:
                    d = Double(ii)
                case let ii as Int32:
                    d = Double(ii)
                case let ii as Double:
                    d = ii
                default:
                    fatalError("oops")
            }
            sum += d
            count += 1
        }
        
        return sum / count
    }
    
    
}
