//
//  OTPViewModel.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/18/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

public protocol PassCodeUseCase {
    func retrievePassCode() -> Observable<String>
    func retrieveOTP() -> Observable<String>
}

public class PassCodeUseCaseProvider: PassCodeUseCase {
    public func retrievePassCode() -> Observable<String> {
        return Observable.just("2345")
    }
    
    public func retrieveOTP() -> Observable<String> {
        let otp = Int.random(in: 100000...999999)
        return Observable.just(String(otp))
    }
}

protocol PassCodeNavigator {
    func toSendMoney(with otp: String, and transaction: Transaction)
}

class DefaultPassCodeNavigator: PassCodeNavigator {
    
    private let navigationController: UINavigationController
    private let services: PassCodeUseCase

    init(services: PassCodeUseCase,
         navigationController: UINavigationController) {
        self.services = services
        self.navigationController = navigationController
    }

    func toSendMoney(with otp: String, and transaction: Transaction) {
        let sendMoneyViewController = SendMoneyViewController(nibName: "SendMoneyViewController", bundle: nil)
        let useCase = SendMoneyUseCaseProvider()
        sendMoneyViewController.viewModel = SendMoneyViewModel(otp: otp, transaction: transaction, useCase: useCase, navigator: DefaultSendMoneyNavigator(services: useCase, navigationController: navigationController))
        navigationController.pushViewController(sendMoneyViewController, animated: true)
    }
}

class PassCodeViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    private var transaction: Transaction
    
    struct Input {
        let loadTrigger: Driver<Void>
        let getOTPTrigger: Driver<Void>
    }
    
    struct Output {
        let passCode: Driver<String>
        let otp: Driver<String>
    }
    
    private let useCase: PassCodeUseCase
    private let navigator: PassCodeNavigator
    
    init(transaction: Transaction, useCase: PassCodeUseCase, navigator: PassCodeNavigator) {
        self.transaction = transaction
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {

        let passCode = input.loadTrigger
            .flatMapLatest {_ in
                return self.useCase.retrievePassCode()
                    .asDriverOnErrorJustComplete()
        }
        
        let otp = input.getOTPTrigger
            .flatMapLatest {_ in
                return self.useCase.retrieveOTP()
                    .asDriverOnErrorJustComplete()
        }
        .do(onNext: {[unowned self]  otp in
            self.navigator.toSendMoney(with: otp, and: self.transaction)
        })
        
        return Output(passCode: passCode, otp: otp)
    }
}
