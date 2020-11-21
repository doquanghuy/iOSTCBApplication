//
//  AppDelegate.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 9/8/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import TCBService
import Domain

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let enviroment = TCBEnvironmentManager.shared.getEnviroment()
        TCBEnvironmentManager.shared.switchEnviroment(into: enviroment ?? .aws, isLaunchApp: true)
        
        // test only
        autoLogin()
        
        return true
    }
    
    // test only
    private func autoLogin() {
        let user = UserCredentials(email: "hoa6", password: "1")
        let useCase = TCBUseCasesProvider().makeLoginUseCase()
        
        useCase.adminLogin { result in
            switch result {
            case .success:
                useCase.login(credentials: user) { [weak self] result in
                    switch result {
                    case let .success(user):
                        let dashboardVC = DashboardViewController(user: user)
                        self?.window?.rootViewController = LargeBarNavigationViewController(rootViewController: dashboardVC)
                        self?.window?.makeKeyAndVisible()
                    case .error: break
                    }
                }
            case .error: break
            }
        }
    }
}
