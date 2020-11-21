//
//  BankListViewModel.swift
//  FastMobile
//
//  Created by Thuy Truong Quang on 9/25/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Domain

class BankListViewModel {
    
    // MARK: - Input, Output
    struct Input {
        let loadListBank: Driver<Void>
        let selectBank: Driver<IndexPath>
        let searchBankTrigger: Driver<String>
//        let loadMoreListBank: Driver<Void>
//        let closeTriger: Driver<Void>
    }
    
    struct Output {
        let listBank: Driver<[Bank]>
        let bankSelected: Driver<Void>
//        let dismissPopup: Driver<Void>
    }
    
    // MARK: - Properties
    private let navigator: BankListNavigator
    private let usecase: BankListUseCase
    var bankItemSelected: PublishSubject<Bank>?
//    private var banks: [Bank]?
    
    // Life circle
    init(navigator: BankListNavigator,
         usecase: BankListUseCase) {
        self.navigator = navigator
        self.usecase = usecase
    }
    
    func transfrom(input: Input) -> Output {
        let listBank = input.loadListBank
            .flatMapLatest {
                self.usecase.listBank("").asDriverOnErrorJustComplete()
            }
       
//        let dismissPopupDrive = input.closeTriger.do(onNext: {
//            self.navigator.dismissPopup()
//        }).asDriver()
        
        let listBankSearch = input.searchBankTrigger.asObservable()
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { searchText in
                return self.usecase.listBank(searchText)
            }.asDriverOnErrorJustComplete()
        
        let list = Driver.merge(listBank, listBankSearch)
        
        let bankSelected = input.selectBank.withLatestFrom(list) { indexPath, banks in
            return banks[indexPath.row]
        }.do(onNext: {
            self.bankItemSelected?.onNext($0)
            self.navigator.dismissWithBankItem($0)
        }).map { _ in}

        return Output(listBank: list,
                      bankSelected: bankSelected)
    }
}
