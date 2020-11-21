//
//  Balance.swift
//  TCBService
//
//  Created by Do Quang Huy on 11/9/20.
//

import Foundation

public struct Balance: Codable {
    public let id: String?
    public let receiverName: String?
    public let amount: Double?
    public let currency: String?
    public let message: String?
    public let status: String?
    public init(id: String?, receiverName: String?, amount: Double?, currency: String?, message: String?, status: String?) {
        self.id = id
        self.receiverName = receiverName
        self.amount = amount
        self.currency = currency
        self.message = message
        self.status = status
    }
}
