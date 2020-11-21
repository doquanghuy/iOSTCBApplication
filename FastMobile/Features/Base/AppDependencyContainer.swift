//
//  QPAppDependencyContainer.swift
//  TCBPay
//
//  Created by Duong Dinh on 7/29/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import UIKit
import Domain

class AppDepedencyContainer {
    
    lazy var signedInDependencyContainer: SignedInDependencyContainer = {
        return SignedInDependencyContainer()
    }()
    
    lazy var mainNavigationController: BaseNavigationViewController = {
        return BaseNavigationViewController()
    }()
    
    private let services: Domain.UseCasesProvider
    
    init(services: Domain.UseCasesProvider) {
        self.services = services
    }
    
    func makeMainViewController(shouldLoad: Bool = true) -> UIViewController {
        let onboardVC = makeOnboardViewController()
        let navigator = DefaultLoadingNavigator(
            navigationController: mainNavigationController,
            onboardViewController: onboardVC,
            homeViewController: makeHomeViewController(),
            services: services)
        
        if shouldLoad {
            let loadingVC = LoadingViewController(navigator: navigator)
            mainNavigationController.setViewControllers([loadingVC], animated: false)
        } else {
            mainNavigationController.setViewControllers([onboardVC], animated: false)
        }
        
        return mainNavigationController
    }
    
    func makeFirstStepLogInViewController() -> FirstStepLogInViewController {
        let navigator = DefaultFirstStepLogInNavigator(services: services,
                                                       navigationController: mainNavigationController,
                                                       homeViewController: makeHomeViewController(),
                                                       registerViewController: makeRegisterViewController())
        let viewModel = FirstStepLoginViewModel(navigator: navigator,
                                                services: services)

        return FirstStepLogInViewController(viewModel: viewModel)
    }
    
    func makeRegisterViewController() -> RegisterViewController {
        let navigator = DefaultRegisterNavigator(services: services,
                                               navigationController: mainNavigationController,
                                               homeViewController: makeHomeViewController())
        let viewModel = RegisterViewModel(registerUseCase: services.makeRegisterUseCase(), loginUseCase: services.makeLoginUseCase(), navigator: navigator)
        return RegisterViewController(viewModel: viewModel)
    }
    
    func makeHomeViewController() -> UIViewController {
        return signedInDependencyContainer.makeHomeViewController() ?? UIViewController()
    }
    
    func makeOnboardViewController() -> OnboardViewController {
        let navigator = DefaultOnboardNavigator(navigationController: mainNavigationController,
                                                loginViewController: makeFirstStepLogInViewController(),
                                                registerViewController: makeRegisterViewController())
        let viewModel = OnboardViewModel(navigator: navigator)

        return OnboardViewController(viewModel: viewModel)
    }
}
