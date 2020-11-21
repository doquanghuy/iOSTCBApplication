//
//  LogInNavigator.swift
//  FastMobile
//
//  Created by Duong Dinh on 10/30/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import Domain
import TCBComponents
import TCBService
import SWRevealViewController

protocol SignInNavigator {
    func showError(_ error: Error)
    func goHome(user: User)
    var actionAfterLogin: ((User) -> Void)? { get }
}

extension Notification.Name {
    static let didFailLogin = Notification.Name("didFailLogin")
}

class DefaultSignInNavigator: SignInNavigator {
    
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

    func showError(_ error: Error) {
        DispatchQueue.main.async {
            var errorMessage = error.message
            if let errorEntity = error as? ErrorEntity {
                errorMessage = errorEntity.errorDescription
            }
            NotificationCenter.default.post(name: .didFailLogin, object: nil)
            let message = TCBNudgeMessage(title: "",
                                         subtitle: errorMessage,
                                         type: .error, onTap: nil, onDismiss: nil)
            TCBNudge.show(message: message)
        }
    }
    
    func goHome(user: User) {
        if let home = homeViewController.getHomeController() {
            home.user = user
            home.services = services
        }
        
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        appDelegate?.window?.rootViewController = self.homeViewController
    }
}

class CustomSignInNavigator: SignInNavigator {
    var actionAfterLogin: ((User) -> Void)?
    
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController,
         actionAfterLogin: ((User) -> Void)? = nil) {
        self.navigationController = navigationController
        self.actionAfterLogin = actionAfterLogin
    }

    func showError(_ error: Error) {
        DispatchQueue.main.async {
            var errorMessage = error.message
            if let errorEntity = error as? ErrorEntity {
                errorMessage = errorEntity.errorDescription
            }
            NotificationCenter.default.post(name: .didFailLogin, object: nil)
            let message = TCBNudgeMessage(title: "",
                                         subtitle: errorMessage,
                                         type: .error, onTap: nil, onDismiss: nil)
            TCBNudge.show(message: message)
        }
    }
    
    func goHome(user: User) {
        actionAfterLogin?(user)
        navigationController.dismiss(animated: true)
    }
}
