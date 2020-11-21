//
//  File.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/1/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import LocalAuthentication

extension LAContext {
    
    var isSupportFaceID: Bool {
        
        var error: NSError?

        guard canEvaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                error: &error) else { return false }
        
        return true
    }
    
    func detectFaceID(_ completion: @escaping (Bool, Error?) -> Void) {
        
        guard isSupportFaceID else {
            completion(false, nil)
            return
        }

        let reason = "Identify yourself!"
        evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                       localizedReason: reason,
                       reply: completion)
    }
}
