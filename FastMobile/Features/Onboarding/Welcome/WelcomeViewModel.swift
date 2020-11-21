//
//  WelcomeViewModel.swift
//  TCBPay
//
//  Created by Dinh Duong on 9/11/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import TCBService
import SWRevealViewController

protocol WelcomeNavigator {
    func goSignIn()
    func goHome(user: User)
    func goRegister()
}

class DefaultWelcomeNavigator: WelcomeNavigator {
    private let navigationController: UINavigationController
    private let signInViewController: FirstStepLogInViewController
    private let homeViewController: UIViewController
    private let services: Domain.UseCasesProvider
    private let registerViewController: RegisterViewController

    init(navigationController: UINavigationController,
         signInViewController: FirstStepLogInViewController,
         registerViewController: RegisterViewController,
         homeViewController: UIViewController,
         services: Domain.UseCasesProvider) {
        self.navigationController = navigationController
        self.signInViewController = signInViewController
        self.registerViewController = registerViewController
        self.homeViewController = homeViewController
        self.services = services
    }
    
    func goSignIn() {
        navigationController.pushViewController(signInViewController, animated: true)
    }

    func goHome(user: User) {
        if let home = homeViewController.getHomeController() {
            home.user = user
            home.services = services
        }
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        appDelegate?.window?.rootViewController = homeViewController
    }
    
    func goRegister() {
        navigationController.pushViewController(registerViewController, animated: true)
    }
}

class WelcomeViewModel: ViewModelType {
    
    struct Input {
        let signInTrigger: Driver<Void>
        let registerTrigger: Driver<Void>
    }
    
    struct Output {
        let gotoSignIn: Driver<Void>
        let gotoRegister: Driver<Void>
    }

    let navigator: WelcomeNavigator
    
    init(navigator: WelcomeNavigator) {
        self.navigator = navigator
    }
    
    func adminLogin() {}
    
    func transform(input: Input) -> Output {
        let gotoSignIn = input.signInTrigger.do(onNext: navigator.goSignIn)
        let gotoRegister = input.registerTrigger.do(onNext: navigator.goRegister)
        return Output(gotoSignIn: gotoSignIn, gotoRegister: gotoRegister)
    }
}
