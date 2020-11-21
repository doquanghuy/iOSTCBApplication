//
//  TransactionNavigatorMock.swift
//  FastMobileTests
//
//  Created by duc on 9/22/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

@testable import FastMobile
import RxCocoa
import Domain

class TransactionNavigatorMock: TransactionNavigator {
    var selectSender_ReturnValue = Driver.just(
        Account(
            id: "1",
            name: "Sender",
            balance: "1,000,000 đ",
            bank: Bank(name: "Techcombank", logo: "group", description: "")
        )
    )
    var selectSender_Called = false

    var selectReceiver_ReturnValue: Driver<Account?> = Driver.just(
        Account(
            id: "2",
            name: "Sender",
            balance: "1,000,000 đ",
            bank: Bank(name: "Techcombank", logo: "group", description: "")
        )
    )
    var selectReceiver_Called = false
    var toConfirmation_Called = false
    var toHome_Called = false

    func toSelectSender() -> Driver<Account> {
        selectSender_Called = true
        return selectSender_ReturnValue
    }

    func toSelectReceiver() -> Driver<Account?> {
        selectReceiver_Called = true
        return selectReceiver_ReturnValue
    }

    func toConfirmation(transaction: Transaction) {
        toConfirmation_Called = true
    }

    func toHome() {
        toHome_Called = true
    }
}
