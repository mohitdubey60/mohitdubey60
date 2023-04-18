//
//  TheadingUtility.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 19/03/23.
//

import UIKit

class ThreadingUtility {
    static func runOnMainThread(_ block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}
