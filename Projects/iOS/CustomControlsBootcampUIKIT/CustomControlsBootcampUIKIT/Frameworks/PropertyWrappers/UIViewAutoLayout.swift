//
//  UIViewAutoLayout.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 14/07/23.
//

import UIKit

@propertyWrapper
struct UIViewAutoLayoutConstraint<T: UIView> {
    var wrappedValue: T {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
