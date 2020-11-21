//
//  FirstStepLogInNavigator.swift
//  FastMobile
//
//  Created by Duong Dinh on 10/30/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit
import Domain
import TCBService
import TCBComponents

protocol FirstStepLogInNavigator {
    func goNext(username: String)
    func showError(_ error: Error, additionalInfo: String?)
    var actionAfterLogin: ((User) -> Void)? { get }
}

extension FirstStepLogInNavigator {
    func showError(_ error: Error, additionalInfo: String? = nil) {
        self.showError(error, additionalInfo: additionalInfo)
    }
}

class DefaultFirstStepLogInNavigator: FirstStepLogInNavigator {
    
    var actionAfterLogin: ((User) -> Void)? = nil
    
    private let navigationController: UINavigationController
    private let services: Domain.UseCasesProvider
    private let homeViewController: UIViewController
    private let registerViewController: RegisterViewController

    init(services: Domain.UseCasesProvider,
         navigationController: UINavigationController,
         homeViewController: UIViewController,
         registerViewController: RegisterViewController) {
        self.navigationController = navigationController
        self.services = services
        self.homeViewController = homeViewController
        self.registerViewController = registerViewController
    }

    func makeSignInViewController(userName: String) -> LoginViewController {
        let navigator = DefaultSignInNavigator(services: services,
                                               navigationController: navigationController,
                                               homeViewController: homeViewController)
        let viewModel = LoginViewModel(useCase: services.makeLoginUseCase(), navigator: navigator, userName: userName)

        return LoginViewController(viewModel: viewModel)
    }
    
    func showError(_ error: Error, additionalInfo: String? = nil) {
        DispatchQueue.main.async {
            var errorMessage = error.message
            if let errorEntity = error as? ErrorEntity {
                errorMessage = errorEntity.errorDescription
            }
                
            let icon: UIImage? = additionalInfo != nil ? UIImage(named: "ic_greenarrow", in: .main, with: nil) : nil
            
            let duration: Double = additionalInfo != nil ? 5 : 2
            let message = TCBNudgeMessage(title: "",
                                         subtitle: errorMessage,
                                         type: .error,
                                         duration: duration,
                                         tapIcon: icon,
                                         onTap: {
                                            guard let additionalInfo = additionalInfo else { return }
                                            self.showRegisterAlert(additionalInfo)
                                         },
                                         onDismiss: nil)
            TCBNudge.show(message: message)
        }
    }
    
    private func showRegisterAlert(_ additionalInfo: String) {
        let alert = UIAlertController(title: "Confirm",
                                      message: "Do you want to register a new account with this user name ?",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .default) { _ in
//            NotificationCenter.default.post(name: .didTapCreateAccount, object: additionalInfo)
            self.registerViewController.viewModel.prefilledUsername = additionalInfo
            self.navigationController.pushViewController(self.registerViewController, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.navigationController.topViewController?.present(alert, animated: true, completion: nil)
    }
    
    func goNext(username: String) {
        navigationController.pushViewController(makeSignInViewController(userName: username), animated: true)
    }
}

class CustomFirstStepLogInNavigator: FirstStepLogInNavigator {
    
    var actionAfterLogin: ((User) -> Void)?
    
    private let navigationController: UINavigationController
    private let services: Domain.UseCasesProvider
    private let registerViewController: RegisterViewController

    init(services: Domain.UseCasesProvider,
         navigationController: UINavigationController,
         registerViewController: RegisterViewController,
         actionAfterLogin: ((User) -> Void)? = nil) {
        self.services = services
        self.navigationController = navigationController
        self.registerViewController = registerViewController
        self.actionAfterLogin = actionAfterLogin
    }

    func makeSignInViewController(userName: String) -> LoginViewController {
        let navigator = CustomSignInNavigator(navigationController: navigationController,
                                              actionAfterLogin: actionAfterLogin)
        let viewModel = LoginViewModel(useCase: services.makeLoginUseCase(),
                                       navigator: navigator,
                                       userName: userName)

        return LoginViewController(viewModel: viewModel)
    }
    
    func showError(_ error: Error, additionalInfo: String? = nil) {
        DispatchQueue.main.async {
            var errorMessage = error.message
            if let errorEntity = error as? ErrorEntity {
                errorMessage = errorEntity.errorDescription
            }
                
            let icon: UIImage? = additionalInfo != nil ? UIImage(named: "ic_greenarrow", in: .main, with: nil) : nil
            let duration: Double = additionalInfo != nil ? 5 : 2
            let message = TCBNudgeMessage(title: "",
                                         subtitle: errorMessage,
                                         type: .error,
                                         duration: duration, tapIcon: icon) {
                guard let additionalInfo = additionalInfo else { return }
                self.showRegisterAlert(additionalInfo)
            } onDismiss: { }
            TCBNudge.show(message: message)
        }
    }
    
    private func showRegisterAlert(_ additionalInfo: String) {
        let alert = UIAlertController(title: "Confirm",
                                      message: "Do you want to register a new account with this user name ?",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .default) { _ in
//            NotificationCenter.default.post(name: .didTapCreateAccount, object: additionalInfo)
            self.registerViewController.viewModel.prefilledUsername = additionalInfo
            self.navigationController.pushViewController(self.registerViewController, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.navigationController.topViewController?.present(alert, animated: true, completion: nil)
    }
    
    func goNext(username: String) {
        navigationController.pushViewController(makeSignInViewController(userName: username), animated: true)
    }
}
