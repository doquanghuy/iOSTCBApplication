//
//  CashflowUseCase.swift
//  Domain
//
//  Created by vuong on 10/16/20.
//

import Foundation

public protocol CashflowUseCase {
    func retrieveCashflow(completion: TCBResponseCompletion<Cashflow>)
}

