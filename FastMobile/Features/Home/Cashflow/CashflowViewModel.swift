//
//  CashflowViewModel.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/11/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

public protocol CashflowUseCase {
    func retrieveCashflow() -> Observable<Cashflow?>
}

public class CashflowUseCaseProvider: CashflowUseCase {

    public func retrieveCashflow() -> Observable<Cashflow?> {
        if let url = Bundle.main.url(forResource: "Cashflow", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Cashflow.self, from: data)
                return Observable.of(jsonData)
            } catch {
                print("error:\(error)")
            }
        }
        return Observable.just(nil)
    }
}

protocol CashflowNavigator {
}

class DefaultCashflowNavigator: CashflowNavigator {

    private let navigationController: UINavigationController?
    private let services: CashflowUseCase

    init(services: CashflowUseCase,
         navigationController: UINavigationController?) {
        self.services = services
        self.navigationController = navigationController
    }
}

class CashflowViewModel: ViewModelType {

    struct Input {
        let loadTrigger: Driver<Void>
    }

    struct Output {
        let cashflow: Driver<Cashflow?>
    }

    private let useCase: CashflowUseCase
    private let navigator: CashflowNavigator

    init(useCase: CashflowUseCase, navigator: CashflowNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }

    func transform(input: Input) -> Output {

        let cashflow = input.loadTrigger
            .flatMapLatest {_ in
                return self.useCase.retrieveCashflow()
                    .asDriverOnErrorJustComplete()
        }

        return Output(cashflow: cashflow.asDriver())
    }
}
