//
//  Product.swift
//  Domain
//
//  Created by Do Quang Huy on 11/9/20.
//

import Foundation

public struct Product: Codable {
    public let id: String?
    public let accountNumber: String?
    public let name: String?
    public let type: String?
    public let amount: Double?
    
    public init(id: String?, accountNumber: String?, name: String?, type: String?, amount: Double?) {
        self.id = id
        self.accountNumber = accountNumber
        self.name = name
        self.type = type
        self.amount = amount
    }
}
