//
//  LoadingNavigator.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 10/30/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import Domain

protocol LoadingNavigator {
    func goOnboard()
    func goHome(user: User)
    func goHomeWithoutLogin()
    func goTo(viewController: UIViewController?)
}

class DefaultLoadingNavigator: LoadingNavigator {
    
    private let navigationController: UINavigationController
    private let onboardViewController: OnboardViewController
    private let homeViewController: UIViewController?
    private let services: Domain.UseCasesProvider
    
    init(navigationController: UINavigationController,
         onboardViewController: OnboardViewController,
         homeViewController: UIViewController?,
         services: Domain.UseCasesProvider) {
        self.services = services
        self.navigationController = navigationController
        self.onboardViewController = onboardViewController
        self.homeViewController = homeViewController
    }
    
    func goOnboard() {
        navigationController.pushViewController(onboardViewController, animated: true)
    }
    
    func goHome(user: User) {
        if let home = homeViewController?.getHomeController() {
            home.user = user
            home.services = services
        }
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        appDelegate?.window?.rootViewController = homeViewController
    }
    
    func goHomeWithoutLogin() {
        if let home = homeViewController?.getHomeController() {
            home.user = User()
            home.services = services
        }
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        appDelegate?.window?.rootViewController = homeViewController
    }
    
    func goTo(viewController: UIViewController?) {
        guard let vc = viewController else { return }
        
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        appDelegate?.window?.rootViewController = vc
    }
}
