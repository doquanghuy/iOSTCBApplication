//
//  RegisterNavigator.swift
//  FastMobile
//
//  Created by Duong Dinh on 10/29/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import Domain
import TCBComponents

protocol RegisterNavigator {
    func showError(_ error: String)
    func goHome(user: User)
    var actionAfterLogin: ((User) -> Void)? { get }
}

class DefaultRegisterNavigator: RegisterNavigator {
    
    var actionAfterLogin: ((User) -> Void)? = nil
    
    private let services: Domain.UseCasesProvider
    private let navigationController: UINavigationController
    private let homeViewController: UIViewController

    init(services: Domain.UseCasesProvider,
         navigationController: UINavigationController,
         homeViewController: UIViewController) {
        self.services = services
        self.homeViewController = homeViewController
        self.navigationController = navigationController
    }

    func showError(_ error: String) {
        DispatchQueue.main.async {
            let message = TCBNudgeMessage(title: "",
                                         subtitle: error,
                                         type: .error, onTap: nil, onDismiss: nil)
            TCBNudge.show(message: message)
        }
    }
    
    func goHome(user: User) {
        DispatchQueue.main.async {
            let message = TCBNudgeMessage(title: "Success",
                                         subtitle: "Register succeeded !",
                                         type: .success, onTap: nil, onDismiss: nil)
            TCBNudge.show(message: message)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if let homeVC = self.homeViewController.getHomeController() {
                homeVC.user = user
                homeVC.services = self.services
            }
            
            let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
            appDelegate?.window?.rootViewController = self.homeViewController
        }
    }
}

class CustomRegisterNavigator: RegisterNavigator {
    var actionAfterLogin: ((User) -> Void)?

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController,
         actionAfterLogin: ((User) -> Void)?) {
        self.navigationController = navigationController
        self.actionAfterLogin = actionAfterLogin
    }
    
    func showError(_ error: String) {
        DispatchQueue.main.async {
            let message = TCBNudgeMessage(title: "",
                                         subtitle: error,
                                         type: .error, onTap: nil, onDismiss: nil)
            TCBNudge.show(message: message)
        }
    }
    
    func goHome(user: User) {
        DispatchQueue.main.async {
            let message = TCBNudgeMessage(title: "Success",
                                         subtitle: "Register succeeded !",
                                         type: .success, onTap: nil, onDismiss: nil)
            TCBNudge.show(message: message)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.actionAfterLogin?(user)
            self.navigationController.dismiss(animated: true)
        }
    }
}
