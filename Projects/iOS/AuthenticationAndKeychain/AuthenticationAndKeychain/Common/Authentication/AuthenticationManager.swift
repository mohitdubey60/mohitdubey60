    //
    //  AuthenticationManager.swift
    //  AuthenticationAndKeychain
    //
    //  Created by mohit.dubey on 19/03/23.
    //

import Foundation

protocol AuthenticationService {
    func authenticateUser(completion: @escaping (Bool, Error?)->Void)
}

class AuthenticationManager {
    var isAuthenticated: Bool = false
    let service: AuthenticationService
    
    static let shared: AuthenticationManager = AuthenticationManager(isAuthenticated: false, service: DeviceAuthenticationService())
    
    private init(isAuthenticated: Bool, service: AuthenticationService) {
        self.isAuthenticated = isAuthenticated
        self.service = service
    }
    
    func authenticateUser(completion: @escaping (Bool, Error?) -> Void) {
        if isAuthenticated {
            completion(self.isAuthenticated, nil)
        } else {
            self.service.authenticateUser {[weak self] success, authenticationError in
                ThreadingUtility.runOnMainThread {[weak self] in
                    guard let self else {
                        completion(false, nil)
                        return
                    }
                    self.isAuthenticated = false
                    
                    if let error = authenticationError {
                        completion(false, error)
                        return
                    }
                    
                    self.isAuthenticated = true
                    completion(true, nil)
                }
            }
        }
    }
}
