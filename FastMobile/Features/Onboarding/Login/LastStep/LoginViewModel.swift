//
//  QPLoginViewModel.swift
//  TCBPay
//
//  Created by Duong Dinh on 7/29/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import Domain
import TCBService

class LoginViewModel: ViewModelType {
    
    struct Input {
        let passwordTrigger: Driver<String>
        let signInTrigger: Driver<Void>
//        let backButtonTrigger: Driver<Void>
    }
    
    struct Output {
        let loginSuccess: Driver<User>
        let signInEnabled: Driver<Bool>
        let isLoggingIn: Driver<Bool>
//        let goBack: Driver<Void>
    }
    
    private let useCase: Domain.LoginUseCase
    private let navigator: SignInNavigator
    private let userName: String
    
    init(useCase: Domain.LoginUseCase, navigator: SignInNavigator, userName: String) {
        self.useCase = useCase
        self.navigator = navigator
        self.userName = userName
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
        let usernameTrigger = BehaviorSubject<String>(value: userName).asDriverOnErrorJustComplete()
        let emailAndPassword = Driver.combineLatest(usernameTrigger, input.passwordTrigger)
        let signIn = input.signInTrigger.withLatestFrom(emailAndPassword)
            .map { email, password in
                return Domain.UserCredentials(email: email, password: password)
            }.flatMapLatest { [unowned self] credentials in
                Observable.create { (observer) -> Disposable in
                    self.useCase.login(credentials: credentials) { result in
                        switch result {
                        case .success(let user):
                            observer.onNext(user ?? User(name: "Error", avatarURL: ""))
                        case .error(let error):
                            observer.onError(error)
                        }
                    }
                    return Disposables.create()
                }.trackActivity(activityIndicator).asDriver { [weak self] error in
                    self?.navigator.showError(error)
                    return Driver.empty()
                }
            }
            .do(onNext: navigator.goHome)
        
        let canSignIn = emailAndPassword.map { email, pasword in
            return self.validate(email: email) && self.validate(password: pasword)
        }
        
//        let backButton = input.backButtonTrigger.do { [weak self] (_) in
//            self?.navigator.goBack()
//        }
        
        return Output(loginSuccess: signIn,
                      signInEnabled: canSignIn,
                      isLoggingIn: activityIndicator.asDriver())
    }
}

// MARK: - Internal
extension LoginViewModel {
    private func validate(email: String) -> Bool {
        return !email.isEmpty
    }
    
    private func validate(password: String) -> Bool {
        return !password.isEmpty
    }
}
