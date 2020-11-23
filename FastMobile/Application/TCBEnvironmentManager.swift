//
//  TCBEnvironmentManager.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/18/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import TCBDomain
import TCBService

public class TCBEnvironmentManager {
    
    public static let shared = TCBEnvironmentManager()
    
    public func setEnviroment(_ enviroment: Environment?) {
        UserDefaults.standard.set(enviroment?.fileName, forKey: "environment")
    }
    
    public func getEnviroment() -> Environment? {
        let fileName = UserDefaults.standard.object(forKey: "environment") as? String
        switch fileName {
        case Environment.aws.fileName:
            return .aws
        case Environment.local.fileName:
            return .local
        default:
            return nil
        }
    }
    
    func switchEnviroment(into enviroment: Environment,
                          shouldShowToast: Bool = true,
                          isLaunchApp: Bool = false) {
        // save
        TCBEnvironmentManager.shared.setEnviroment(enviroment)
        
        // change
        try? TCBService.initialize(enviroment: enviroment, auth: .identity)
    }
}
