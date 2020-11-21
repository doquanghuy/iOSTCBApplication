//
//  CashflowUseCaseMock.swift
//  FastMobileTests
//
//  Created by Huy TO. Nguyen Van on 9/22/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

@testable import FastMobile
import RxSwift
import Domain

class CashflowUseCaseMock: CashflowUseCase {
    var retrieveCashflow_ReturnValue: Observable<Cashflow?> = Observable.just(nil)
    var retrieveCashflow_Called = false
    
    func retrieveCashflow() -> Observable<Cashflow?> {
        retrieveCashflow_Called = true
        return retrieveCashflow_ReturnValue
    }

}
