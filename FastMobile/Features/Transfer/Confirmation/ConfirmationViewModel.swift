//
//  ConfirmationViewModel.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 9/21/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Domain
import TCBService
import TCBComponents

public protocol ConfirmationUseCase {
}

public class ConfirmationUseCaseProvider: ConfirmationUseCase {
}

protocol ConfirmationNavigator {
    func toPassCodeScreen(transaction: Transaction, balance: Balance)
}

class DefaultConfirmationNavigator: ConfirmationNavigator {
    private let navigationController: UINavigationController
    private let services: ConfirmationUseCase
    
    init(services: ConfirmationUseCase,
         navigationController: UINavigationController) {
        self.services = services
        self.navigationController = navigationController
    }
    
    func toPassCodeScreen(transaction: Transaction, balance: Balance) {
        //        let passCodeViewController = PassCodeViewController(nibName: "PassCodeViewController", bundle: nil)
        //        let useCase = PassCodeUseCaseProvider()
        //        passCodeViewController.viewModel = PassCodeViewModel(transaction: transaction, useCase: useCase, navigator: DefaultPassCodeNavigator(services: useCase, navigationController: navigationController))
        //        navigationController.pushViewController(passCodeViewController, animated: true)
        let successfulTransactionViewController = SuccessfulTransactionViewController(nibName: "SuccessfulTransactionViewController", bundle: nil)
        let useCase = SuccessfulTransactionUseCaseProvider()
        successfulTransactionViewController.viewModel = SuccessfulTransactionViewModel(transaction: transaction, useCase: useCase, navigator: DefaultSuccessfulTransactionNavigator(services: useCase, navigationController: navigationController))
        successfulTransactionViewController.balance = balance
        navigationController.pushViewController(successfulTransactionViewController, animated: true)
    }
}

class ConfirmationViewModel: ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let confirmTrigger: Driver<Void>
    }
    
    struct Output {
        let transaction: Driver<Transaction>
        let toPassCodeScreen: Driver<Void>
        let showLoading: BehaviorRelay<Bool>
    }
    
    private let useCase: ConfirmationUseCase
    private let navigator: ConfirmationNavigator
    private var transaction: Transaction
    private let showLoading = BehaviorRelay<Bool>(value: false)
    
    var selectedBeneficiaryValue: Beneficiary? = nil
    
    init(transaction: Transaction,
         useCase: ConfirmationUseCase,
         navigator: ConfirmationNavigator) {
        
        self.transaction = transaction
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        
        let transaction = input.loadTrigger
            .flatMapLatest {_ in
                return Driver.just(self.transaction)
            }
        
        let toPassCodeScreen = input.confirmTrigger.do(onNext: {[unowned self]  _ in
            self.makePayment()
        })
        
        return Output(transaction: transaction, toPassCodeScreen: toPassCodeScreen, showLoading: showLoading)
    }
    
    private func makePayment() {
        guard let receiver = transaction.receiver else {
            return
        }
        
        let paymentInfo = PaymentInfo(identificationSender: transaction.sender.id,
                                      amount: transaction.amount,
                                      receiverName: receiver.name,
                                      receiverIdentification: receiver.accountNumber,
                                      message: transaction.message)
        
        showLoading.accept(true)
        
        TCBUseCasesProvider()
            .makePaymentUseCase()
            .makePayment(paymentInfo: paymentInfo) { [weak self] (balance) in
                
                guard let self = self else { return }
                
                self.showLoading.accept(false)
                
                switch balance {
                case let .success(bal):
                    guard let bal = bal else { return }
                    self.navigator.toPassCodeScreen(transaction: self.transaction,
                                                    balance: bal)
                    UserDefaults.saveSeletedLatestBeneficiaryToUserDefault(item: self.selectedBeneficiaryValue)
                    self.sendPaymentNotification(userId: self.transaction.receiver?.name)
                case let .error(err):
                    let message = TCBNudgeMessage(title: "Error",
                                                 subtitle: err.localizedDescription,
                                                 type: .error)
                    TCBNudge.show(message: message)
                }
            }
    }
    
    private func sendPaymentNotification(userId :String?) {
        guard let userId = userId?
                .replacingOccurrences(of: "Account", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        TCBUseCasesProvider()
            .makeFiresbaseUseCase()
            .sendPaymentNotification(userId: userId) { (result) in
                
            switch result {
            case let .success(data):
                print(data ?? "")
            case let .error(err):
                print(err)
            }
        }
    }
}
