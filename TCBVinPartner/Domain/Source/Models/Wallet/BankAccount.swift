//
//  BankAccount.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 10/2/20.
//

import Foundation

public struct BankAccount: Codable {

    public var _id: Int64?
    public var customerId: Int64?
    public var active: Bool?
    public var status: Int?
    public var currency: String?
    public var multiCurrency: Bool?
    public var issuerId: Int64?
    public var issuerName: String?
    public var type: Int?
    public var limitSetId: Int64?
    public var hash: String?
    public var spareFields: SpareFields?
    public var accountHolderName: String?
    public var accountNumber: String?
    public var displayNumber: String?
    public var bankCode: String?
    public var branchCode: String?
    public var bankName: String?
    public var bankCountry: String
    public var bankCity: String?
    public var lastUpdate: Date?

    public init(_id: Int64?, customerId: Int64?, active: Bool?, status: Int?, currency: String?, multiCurrency: Bool?, issuerId: Int64?, issuerName: String?, type: Int?, limitSetId: Int64?, hash: String?, spareFields: SpareFields?, accountHolderName: String?, accountNumber: String?, displayNumber: String?, bankCode: String?, branchCode: String?, bankName: String?, bankCountry: String, bankCity: String?, lastUpdate: Date?) {
        self._id = _id
        self.customerId = customerId
        self.active = active
        self.status = status
        self.currency = currency
        self.multiCurrency = multiCurrency
        self.issuerId = issuerId
        self.issuerName = issuerName
        self.type = type
        self.limitSetId = limitSetId
        self.hash = hash
        self.spareFields = spareFields
        self.accountHolderName = accountHolderName
        self.accountNumber = accountNumber
        self.displayNumber = displayNumber
        self.bankCode = bankCode
        self.branchCode = branchCode
        self.bankName = bankName
        self.bankCountry = bankCountry
        self.bankCity = bankCity
        self.lastUpdate = lastUpdate
    }

    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case customerId
        case active
        case status
        case currency
        case multiCurrency
        case issuerId
        case issuerName
        case type
        case limitSetId
        case hash
        case spareFields
        case accountHolderName
        case accountNumber
        case displayNumber
        case bankCode
        case branchCode
        case bankName
        case bankCountry
        case bankCity
        case lastUpdate
    }

}
