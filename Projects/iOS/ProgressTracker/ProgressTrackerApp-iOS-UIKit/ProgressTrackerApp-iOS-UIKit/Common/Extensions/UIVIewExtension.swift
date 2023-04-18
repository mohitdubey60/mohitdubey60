//
//  UIVIewExtension.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 14/02/23.
//

import UIKit

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
