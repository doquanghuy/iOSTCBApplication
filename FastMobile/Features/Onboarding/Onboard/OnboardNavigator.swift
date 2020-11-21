//
//  OnboardNavigator.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 10/30/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit

protocol OnboardNavigator {
    var shouldShowNavigationBar: Bool { get }
    func goLogin()
    func goRegister()
}

class DefaultOnboardNavigator: OnboardNavigator {
    
    private let navigationController: UINavigationController
    private let loginViewController: FirstStepLogInViewController
    private var registerViewController: UIViewController
    
    init(navigationController: UINavigationController,
         loginViewController: FirstStepLogInViewController,
         registerViewController: UIViewController) {
        
        self.navigationController = navigationController
        self.loginViewController = loginViewController
        self.registerViewController = registerViewController
        
//        NotificationCenter.default.addObserver(self, selector: #selector(goRegisterFromLogin(_:)), name: .didTapCreateAccount, object: nil)
    }
    
    @objc private func goRegisterFromLogin(_ notification: Notification) {
        guard let prefilledUsername = notification.object as? String else { return }
        guard let registerVC = registerViewController as? RegisterViewController else { return }
        registerVC.viewModel.prefilledUsername = prefilledUsername
        guard let welcomeVC = navigationController.viewControllers.first(where: { (viewController) -> Bool in
            return viewController.isKind(of: OnboardViewController.self)
        }) else { return }
        navigationController.popToViewController(welcomeVC, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.goRegister()
        }
    }
    
    var shouldShowNavigationBar: Bool = false
    
    func goLogin() {
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func goRegister() {
         navigationController.pushViewController(registerViewController, animated: true)
    }
}

class CustomOnboardNavigator: OnboardNavigator {
    private let navigationController: UINavigationController
    private let loginViewController: FirstStepLogInViewController
    private let registerViewController: UIViewController
    
    init(navigationController: UINavigationController,
         loginViewController: FirstStepLogInViewController,
         registerViewController: UIViewController) {
        
        self.navigationController = navigationController
        self.loginViewController = loginViewController
        self.registerViewController = registerViewController
    }
    
    var shouldShowNavigationBar: Bool = true
    
    func goLogin() {
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func goRegister() {
        navigationController.pushViewController(registerViewController, animated: true)
    }
}
