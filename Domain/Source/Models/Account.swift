//
//  Account.swift
//  FastMobile
//
//  Created by duc on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

public struct Account: Codable {
    public let id: String
    public let accountNumber: String
    public let name: String
    public let nickname: String?
    public let balance: Double
    public let bank: Bank?
    public let type: String?

    public init(id: String,
                accountNumber: String,
                name: String,
                nickname: String? = nil,
                balance: Double,
                type: String? = nil,
                bank: Bank? = Bank(name: "Techcombank", logo: "group", description: "")) {
        
        self.id = id
        self.accountNumber = accountNumber
        self.name = name
        self.nickname = nickname
        self.balance = balance
        self.type = type
        self.bank = bank
    }
}
