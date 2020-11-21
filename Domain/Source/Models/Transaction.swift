//
//  Transaction.swift
//  FastMobile
//
//  Created by duc on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

public struct Transaction {
    public let sender: Account
    public let receiver: Account?
    public var amount: Double
    public let message: String
    public let fee: String

    public init(sender: Account, receiver: Account? = nil, amount: Double, message: String, fee: String) {
        self.sender = sender
        self.receiver = receiver
        self.amount = amount
        self.message = message
        self.fee = fee
    }
}
