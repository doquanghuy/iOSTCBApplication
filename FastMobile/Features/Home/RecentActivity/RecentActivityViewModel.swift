//
//  RecentActivityViewModel.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/11/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import TCBService

protocol RecentActivityNavigator {
    func gotoTransfer(sender: Account, receiver: Account)
}

class DefaultRecentActivityNavigator: RecentActivityNavigator {
    
    private let navigationController: UINavigationController?
    private let services: RecentActivityUseCase
    
    init(services: RecentActivityUseCase,
         navigationController: UINavigationController?) {
        self.services = services
        self.navigationController = navigationController
    }
    
    func gotoTransfer(sender: Account, receiver: Account) {
        guard let navigationController = navigationController else {
            return
        }
        
        DispatchQueue.main.async {
            let transactionViewController = TransactionViewController()
            transactionViewController.viewModel =
                TransactionViewModel(useCase: DefaultTransactionUseCase(),
                                     navigator: DefaultTransactionNavigator(navigationController: navigationController),
                                     senderAccount: sender,
                                     receiverAccount: receiver)
            navigationController.pushViewController(transactionViewController, animated: true)
        }
    }
}

class RecentActivityViewModel: ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let refeshDataTrigger: Driver<Void>
        let selectedItemTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let recentActivities: Driver<[TransactionItem]>
        let selectedItem: Driver<TransactionItem>
    }
    
    var currentAccount: Account?
    
    private let useCase: RecentActivityUseCase
    private let navigator: RecentActivityNavigator
    
    init(useCase: RecentActivityUseCase, navigator: RecentActivityNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let sender = Driver.merge(input.loadTrigger, input.refeshDataTrigger)
        
        let recentActivities = sender.flatMapLatest {[unowned self] _ -> Driver<[TransactionItem]> in
            Observable.create { observable in
                self.useCase.retrieveRecentActivities { (result) in
                    switch result {
                    case .success(let value):
                        guard let values = value else {
                            observable.onNext([])
                            return
                        }
                        
                        observable.onNext(values.sorted { $0.bookingDate > $1.bookingDate})
                        
                    case .error(let error):
                        observable.onError(error)
                    }
                }
                return Disposables.create()
            }.asDriverOnErrorJustComplete()
        }
        
        let selectedItem = input.selectedItemTrigger
            .withLatestFrom(recentActivities) { $1[$0.row] }
            .do(onNext: { [weak self] item in
                
                guard let receiverName = item.receiverName else { return }
                
                self?.getIBAN(frome: receiverName, completion: { [weak self] number in
                    guard let number = number, let sender = self?.currentAccount else { return }
                    
                    self?.navigator.gotoTransfer(sender: sender,
                                                 receiver: Account(id: item.id,
                                                                   accountNumber: number,
                                                                   name: receiverName,
                                                                   balance: 0.0))
                })
            })
        
        return Output(recentActivities: recentActivities,
                      selectedItem: selectedItem)
    }
    
    private func getIBAN(frome useAccountName: String, completion: @escaping (String?) -> Void) {
        useCase.getIBANfromUserAccountName(useAccountName: useAccountName) { result in
            switch result {
            case let .success(card):
                completion(card??.iban)
            case .error:
                completion(nil)
            }
        }
    }
}
