//
//  RegisterViewModel.swift
//  FastMobile
//
//  Created by Duong Dinh on 10/29/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import Domain
import TCBService

class RegisterViewModel: ViewModelType {
    
    struct Input {
        let emailTrigger: Driver<String>
        let passwordTrigger: Driver<String>
        let usernameTrigger: Driver<String>
        let firstNameTrigger: Driver<String>
        let lastNameTrigger: Driver<String>
        let registerTrigger: Driver<Void>
    }
    
    struct Output {
        let registerSuccess: Driver<User>
        let registerEnabled: Driver<Bool>
        let isRegisteringIn: Driver<Bool>
    }
    
    private let registerUseCase: Domain.RegisterUseCase
    private let navigator: RegisterNavigator
    private let loginUseCase: Domain.LoginUseCase
    var prefilledUsername: String?
    
    init(registerUseCase: Domain.RegisterUseCase, loginUseCase: Domain.LoginUseCase, navigator: RegisterNavigator, prefilledUsername: String? = nil) {
        self.registerUseCase = registerUseCase
        self.loginUseCase = loginUseCase
        self.navigator = navigator
        self.prefilledUsername = prefilledUsername
    }
    
    func getProfile() {
        let provider = TCBAccountUseCase()
        provider.retrieveData { (result) in
            switch result {
            case .success(let item): print(item ?? "")
            case .error(let error): print("Error: \(error)")
            }
        }
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let registerInfo = Driver.combineLatest(input.emailTrigger,
                                                input.passwordTrigger,
                                                input.firstNameTrigger,
                                                input.lastNameTrigger,
                                                input.usernameTrigger)
        
        let register = input.registerTrigger.withLatestFrom(registerInfo)
            .map { email, password, firstName, lastName, userName in
                return Domain.User(firstName: firstName,
                                   lastName: lastName,
                                   email: email,
                                   userCredentials: UserCredentials(email: userName, password: password))
            }.flatMapLatest { [unowned self] credentials in
                Observable.create { (observer) -> Disposable in
                    self.registerUseCase.register(user: credentials) { (result) in
                        switch result {
                        case .success(let user):
                            if let userCredentials = user?.userCredentials {
                                self.loginUseCase.login(credentials: userCredentials) { (loginResult) in
                                    switch loginResult {
                                    case .success(let loggedInUser):
                                        observer.onNext(loggedInUser ?? User())
                                    case .error(let error):
                                        observer.onError(error)
                                    }
                                }
                            } else {
                                observer.onNext(User())
                            }
                        case .error(let error):
                            observer.onError(error)
                        }
                    }
                    return Disposables.create()
                }.trackActivity(activityIndicator).asDriver { [weak self] error in
                    self?.navigator.showError(error.message)
                    return Driver.empty()
                }
            }
            .do(onNext: navigator.goHome)
        
        let canRegister = registerInfo.map { email, pasword, username, firstName, lastName in
            return self.validate(email) && self.validate(pasword) && self.validate(username) && self.validate(firstName) && self.validate(lastName)
        }
        
        return Output(registerSuccess: register,
                      registerEnabled: canRegister,
                      isRegisteringIn: activityIndicator.asDriver())
    }
}

// MARK: - Internal
extension RegisterViewModel {
    private func validate(_ string: String) -> Bool {
        return !string.isEmpty
    }
}
