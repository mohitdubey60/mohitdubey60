//
//  CoreDataTimeExtension.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 09/02/23.
//

import Foundation
import CoreData

public class Time: ValueTransformer {
    let hour: Int
    let minute: Int
    let second: Int
    
    override init() { // only sample code
        hour = 0
        minute = 0
        second = 0
    }
    
    public override class func transformedValueClass() -> AnyClass {
        return NSNumber.self
    }
    
    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let number = value as? NSNumber else {
            return nil
        }
    
        return Time() // you should init Time from the number
    }
    
    public override func transformedValue(_ value: Any?) -> Any? {
        let number = hour * 60 * 60 + minute * 60 + second
        return number
    }
    
    public override class func allowsReverseTransformation() -> Bool {
        return true
    }
}
