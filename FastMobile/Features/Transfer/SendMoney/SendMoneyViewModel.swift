//
//  SendMoneyViewModel.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

public protocol SendMoneyUseCase {
    func retrieveOTP() -> Observable<String>
}

public class SendMoneyUseCaseProvider: SendMoneyUseCase {
    
    public func retrieveOTP() -> Observable<String> {
        let otp = Int.random(in: 100000...999999)
        return Observable.just(String(otp))
    }
}

protocol SendMoneyNavigator {
    func toSuccessfulTransactionScreen(_ transaction: Transaction)
}

class DefaultSendMoneyNavigator: SendMoneyNavigator {
    private let navigationController: UINavigationController
    private let services: SendMoneyUseCase

    init(services: SendMoneyUseCase,
         navigationController: UINavigationController) {
        self.services = services
        self.navigationController = navigationController
    }

    func toSuccessfulTransactionScreen(_ transaction: Transaction) {
        let successfulTransactionViewController = SuccessfulTransactionViewController(nibName: "SuccessfulTransactionViewController", bundle: nil)
        let useCase = SuccessfulTransactionUseCaseProvider()
        successfulTransactionViewController.viewModel = SuccessfulTransactionViewModel(transaction: transaction, useCase: useCase, navigator: DefaultSuccessfulTransactionNavigator(services: useCase, navigationController: navigationController))
        navigationController.pushViewController(successfulTransactionViewController, animated: true)
    }
}

class SendMoneyViewModel: ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let sendMoneyTrigger: Driver<Void>
        let timerDidEndTrigger: Driver<Void>
    }
    
    struct Output {
        let otp: Driver<String>
        let toSuccessfulTransactionScreen: Driver<Void>
        let changeOTP: Driver<String>
    }
    
    private let useCase: SendMoneyUseCase
    private let navigator: SendMoneyNavigator
    private var transaction: Transaction
    private var otp: String
    
    init(otp: String, transaction: Transaction, useCase: SendMoneyUseCase, navigator: SendMoneyNavigator) {
        self.otp = otp
        self.transaction = transaction
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {

        let otp = input.loadTrigger
            .flatMapLatest {_ in
                return self.useCase.retrieveOTP()
                    .asDriverOnErrorJustComplete()
        }
        
        let toSuccessfulTransactionScreen = input.sendMoneyTrigger
        .do(onNext: {[unowned self]  _ in
            self.navigator.toSuccessfulTransactionScreen(self.transaction)
        })
        
        let changeOTP = input.timerDidEndTrigger
            .flatMapLatest { _ in
                return self.useCase.retrieveOTP()
                    .asDriverOnErrorJustComplete()
        }
        
        return Output(otp: otp, toSuccessfulTransactionScreen: toSuccessfulTransactionScreen, changeOTP: changeOTP)
    }
}
