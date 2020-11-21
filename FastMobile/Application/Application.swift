//
//  Application.swift
//  FastMobile
//
//  Created by vuong on 10/15/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit
import TCBService
import IQKeyboardManagerSwift
import Domain

final class Application: NSObject {
    
    private var appDependencyContainer: AppDepedencyContainer
    private var window: UIWindow!
    
    init(useCasesProvider: Domain.UseCasesProvider) {
        appDependencyContainer = AppDepedencyContainer(services: useCasesProvider)
        super.init()
    }
    
    func configure(with window: UIWindow?) -> Bool {
        guard let window = window  else {
            return false
        }
        self.window = window

        let enviroment = TCBEnvironmentManager.shared.getEnviroment()
        TCBEnvironmentManager.shared.switchEnviroment(into: enviroment ?? .aws, with: self.window, isLaunchApp: true)
        IQKeyboardManager.shared.enable = true

        return true
    }
}

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
    
    func switchEnviroment(into enviroment: Environment, with window: UIWindow? = UIApplication.shared.getKeyWindow()?.window, shouldShowToast: Bool = true, isLaunchApp: Bool = false) {
        //
        if !isLaunchApp {
            TCBSessionManager.shared.clearAllToken()
        }
        // save
        TCBEnvironmentManager.shared.setEnviroment(enviroment)
        
        // change
        try? TCBService.initialize(enviroment: enviroment, auth: .identity)

        window?.rootViewController = AppDepedencyContainer(services: TCBUseCasesProvider()).makeMainViewController()
        window?.makeKeyAndVisible()

        if shouldShowToast {
            window?.makeToast("Switched into \(enviroment) enviroment")
        }
    }
}
