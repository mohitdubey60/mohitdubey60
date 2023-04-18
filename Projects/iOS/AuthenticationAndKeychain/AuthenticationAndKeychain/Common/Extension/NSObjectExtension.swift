//
//  NSObjectExtension.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 20/03/23.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
