//
//  DeviceAuthenticationService.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 19/03/23.
//

import LocalAuthentication

enum AuthenticationError: Error {
    case cannotAuthenticate
}

class DeviceAuthenticationService: AuthenticationService {
    private func evaluateAuthentication(_ context: LAContext, _ policy: LAPolicy, _ reason: String, _ error: inout NSError?, _ completion: @escaping (Bool, Error?) -> Void) {
        context.evaluatePolicy(policy, localizedReason: reason) {[weak error] success, authenticationError in
            error = authenticationError as NSError?
            if success {
                completion(true, error)
            } else {
                completion(false, error)
            }
        }
    }
    
    func authenticateUser(completion: @escaping (Bool, Error?)->Void) {
        let context = LAContext()
        var error: NSError?
        let reason = "Identify yourself"
        
//      If you want to access only faceId or biometric and not passcode then use deviceOwnerAuthenticationWithBiometrics
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            evaluateAuthentication(context, .deviceOwnerAuthenticationWithBiometrics, reason, &error, completion)
//        } else
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            evaluateAuthentication(context, .deviceOwnerAuthentication, reason, &error, completion)
        } else {
            Swift.print("Mohit: Error: Device authentication not available")
            completion(false, AuthenticationError.cannotAuthenticate)
        }
    }
}
