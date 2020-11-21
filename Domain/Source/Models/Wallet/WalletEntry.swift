//
//  WalletEntry.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 10/2/20.
//

import Foundation

public struct WalletEntry: Codable {

    public var _id: Int64?
    public var customerId: Int64?
    public var paymentInstrumentId: Int64?
    public var debitPriority: Int?
    public var creditPriority: Int?
    public var limitSetId: Int64?
    public var alias: String?
    public var bankAccount: BankAccount?
    public var creditCard: CreditCard?
    public var externalAccount: ExternalAccount?
    public var sva: SVA?
    public var offlineSva: OfflineSVA?

    public init(_id: Int64?, customerId: Int64?, paymentInstrumentId: Int64?, debitPriority: Int?, creditPriority: Int?, limitSetId: Int64?, alias: String?, bankAccount: BankAccount?, creditCard: CreditCard?, externalAccount: ExternalAccount?, sva: SVA?, offlineSva: OfflineSVA?) {
        self._id = _id
        self.customerId = customerId
        self.paymentInstrumentId = paymentInstrumentId
        self.debitPriority = debitPriority
        self.creditPriority = creditPriority
        self.limitSetId = limitSetId
        self.alias = alias
        self.bankAccount = bankAccount
        self.creditCard = creditCard
        self.externalAccount = externalAccount
        self.sva = sva
        self.offlineSva = offlineSva
    }

    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case customerId
        case paymentInstrumentId
        case debitPriority
        case creditPriority
        case limitSetId
        case alias
        case bankAccount
        case creditCard
        case externalAccount
        case sva
        case offlineSva
    }

}
