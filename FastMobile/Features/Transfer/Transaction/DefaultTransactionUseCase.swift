//
//  DefaultTransactionUseCase.swift
//  FastMobile
//
//  Created by duc on 9/21/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import RxSwift
import Domain
import TCBComponents

class DefaultTransactionUseCase: TransactionUseCase {
    func defaultSender() -> Observable<Account> {
        let bank = Bank(name: "Techcombank",
                        logo: "group",
                        description: "",
                        code: "111000025",
                        bic: "INGBNL2A",
                        address: "FINANCIAL PLAZA BIJLMERDREEF 109 1102 BW AMSTERDAM",
                        country: "NL"
                        )
        if let accountData = UserDefaults.standard.object(forKey: "AcountItem") as? Data {
            if let acountItem = try? JSONDecoder().decode(Account.self, from: accountData) {
                return Observable.just(acountItem)
            }
        }
        return Observable.just(
            Account(
                id: "",
                accountNumber: "1900123456789",
                name: "Tài khoản thanh toán",
                balance: 20000000,
                bank: bank
            )
        )
    }
}
