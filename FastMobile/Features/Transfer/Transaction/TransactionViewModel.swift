//
//  TransactionViewModel.swift
//  FastMobile
//
//  Created by duc on 9/18/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Domain
import TCBComponents
import TCBService

class TransactionViewModel: ViewModelType {
    struct Input {
        let loadSenderTrigger: Driver<Void>
        let selectSenderTrigger: Driver<UITapGestureRecognizer>
        let loadReceiverTrigger: Driver<Void>
        let selectReceiverTrigger: Driver<Void>
        let updateAmountTrigger: Driver<String>
        let updateMessageTrigger: Driver<String>
        let confirmTransactionTrigger: Driver<Void>
        let backTrigger: Driver<Void>
    }
    
    struct Output {
        let sender: Driver<Account>
        let receiver: Driver<Account?>
        let amountDescription: Driver<String>
        let canConfirm: Driver<Bool>
        let isTransactionValid: Driver<Bool>
        let confirm: Driver<Transaction>
        let dismiss: Driver<Void>
    }
    
    private let useCase: TransactionUseCase
    private let navigator: TransactionNavigator
    private let senderAccount: Account
    private let receiverAccount: Account?

    init(useCase: TransactionUseCase,
         navigator: TransactionNavigator,
         senderAccount: Account,
         receiverAccount: Account? = nil) {
        self.useCase = useCase
        self.navigator = navigator
        self.senderAccount = senderAccount
        self.receiverAccount = receiverAccount
    }
    
    func transform(input: Input) -> Output {
        let defaultSender = input.loadSenderTrigger
            .flatMapLatest {
                Observable.just(self.senderAccount)
                    .asDriverOnErrorJustComplete()
            }
        let selectSender = input.selectSenderTrigger
            .flatMapLatest { _ in
                self.navigator.toSelectSender()
        }
        let sender = Driver.merge(defaultSender, selectSender)
        
        let defaultReceiver = input.loadReceiverTrigger
            .flatMapLatest {
                Observable.just(self.receiverAccount)
                    .asDriverOnErrorJustComplete()
            }
        
        let selectReceiver = input.selectReceiverTrigger
            .flatMapLatest {
                self.navigator.toSelectReceiver()
        }
        let receiver = Driver.merge(defaultReceiver, selectReceiver)
        
        let amountDescription = input.updateAmountTrigger
            .flatMapLatest {
                Driver.just($0.asWord?.capitalized == nil ? "" : $0.asWord!.capitalized + " Dong")
        }
        let transaction = Driver.combineLatest(sender, receiver, input.updateAmountTrigger, input.updateMessageTrigger)
            .flatMapLatest { sender, receiver, amount, message in
            return Driver.just(
                Transaction(sender: sender,
                            receiver: receiver,
                            amount: amount.doubleValue,
                            message: message,
                            fee: "0")
                )
        }
        
        let isTransactionValid = transaction.map { $0.sender.balance >= $0.amount}

        let canConfirm = transaction.map { $0.receiver != nil && $0.amount > 0 }

        let confirm = input.confirmTransactionTrigger
            .withLatestFrom(transaction)
            .do(onNext: navigator.toConfirmation)
        
        let dismiss = input.backTrigger.do(onNext: navigator.toHome)
        
        
        return Output(
            sender: sender,
            receiver: receiver,
            amountDescription: amountDescription,
            canConfirm: canConfirm,
            isTransactionValid: isTransactionValid,
            confirm: confirm,
            dismiss: dismiss
        )
    }
}
