//
//  TransactionUseCaseMock.swift
//  FastMobileTests
//
//  Created by duc on 9/22/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

@testable import FastMobile
import RxSwift
import Domain

class TransactionUseCaseMock: TransactionUseCase {
    var defaultSender_ReturnValue = Observable.just(
        Account(
            id: "3",
            name: "Sender",
            balance: "1,000,000 đ",
            bank: Bank(name: "Techcombank", logo: "group", description: "")
        )
    )
    var defaultSender_Called = false

    func defaultSender() -> Observable<Account> {
        defaultSender_Called = true
        return defaultSender_ReturnValue
    }
}
