//
//  AppDelegate.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 9/8/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import TCBService
import TCBDomain

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let enviroment = TCBEnvironmentManager.shared.getEnviroment()
        TCBEnvironmentManager.shared.switchEnviroment(into: enviroment ?? .aws, isLaunchApp: true)
        
        autoLogin()
        
        return true
    }
    
    // test only
    private func autoLogin() {
        
        let userCredentials = UserCredentials(email: "hoa6", password: "1")
        let useCase = TCBUseCasesProvider().makeLoginUseCase()
        
        useCase.login(credentials: userCredentials) { [weak self] result in
            switch result {
            case let .success(user):
                
                // fix user's type
                let type: User.UserType =
                    (user?.email?.contains("hoa") ?? false) ? .vinPartner : .default
                var cloneUser = user
                cloneUser?.type = type
                
                let dashboardVC = DashboardViewController(user: cloneUser)
                self?.window?.rootViewController = LargeBarNavigationViewController(rootViewController: dashboardVC)
                self?.window?.makeKeyAndVisible()
            case .error: break
            }
        }
    }
}
