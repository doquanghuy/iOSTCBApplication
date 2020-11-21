//
//  SuccessfulTransactionViewModel.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 9/21/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

public protocol SuccessfulTransactionUseCase {
}

public class SuccessfulTransactionUseCaseProvider: SuccessfulTransactionUseCase {
}

protocol SuccessfulTransactionNavigator {
    func toHomeScreen()
    func toSharingScreen(transactionImage: UIImage?)
}

class DefaultSuccessfulTransactionNavigator: SuccessfulTransactionNavigator {
    private let navigationController: UINavigationController
    private let services: SuccessfulTransactionUseCase

    init(services: SuccessfulTransactionUseCase,
         navigationController: UINavigationController) {
        self.services = services
        self.navigationController = navigationController
    }
    
    func toHomeScreen() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func toSharingScreen(transactionImage: UIImage?) {
        let sharingViewController = SharingViewController(nibName: "SharingViewController", bundle: nil)
        let useCase = SharingUseCaseProvider()
        sharingViewController.viewModel = SharingViewModel(transactionImage: transactionImage, useCase: useCase, navigator: DefaultSharingNavigator(services: useCase, navigationController: navigationController))
        sharingViewController.prepareToPresentAsPanel()
        navigationController.present(sharingViewController, animated: true)
    }
}

class SuccessfulTransactionViewModel: ViewModelType {

    struct Input {
        let loadTrigger: Driver<Void>
        let backToHomeTrigger: Driver<Void>
        let sharingTrigger: Driver<Void>
        let generateSharedImage: () -> UIImage?
    }
    
    struct Output {
        let transaction: Driver<Transaction>
        let toHomeScreen: Driver<Void>
        let toSharingScreen: Driver<Void>
    }
    
    private let useCase: SuccessfulTransactionUseCase
    private let navigator: SuccessfulTransactionNavigator
    private var transaction: Transaction
    
    init(transaction: Transaction, useCase: SuccessfulTransactionUseCase, navigator: SuccessfulTransactionNavigator) {
        self.transaction = transaction
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {

        let transaction = input.loadTrigger
            .flatMapLatest {_ in
                return Driver.just(self.transaction)
        }
        
        let toHomeScreen = input.backToHomeTrigger
        .do(onNext: {[unowned self]  _ in
            self.navigator.toHomeScreen()
        })
        
        let toSharingScreen = input.sharingTrigger.do { [unowned self] _ in
            self.navigator.toSharingScreen(transactionImage: input.generateSharedImage())
        }
        
        return Output(transaction: transaction, toHomeScreen: toHomeScreen, toSharingScreen: toSharingScreen)
    }
}
