//
//  CreditCard.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 10/2/20.
//

import Foundation

public struct CreditCard: Codable {

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
    public var cardType: Int?
    public var cardNumber: String
    public var securityNumber: String?
    public var yearExpiry: Int?
    public var monthExpiry: Int?
    public var cardHolderName: String?
    public var cardIssueNumber: Int?
    public var displayNumber: String?

    public init(_id: Int64?, customerId: Int64?, active: Bool?, status: Int?, currency: String?, multiCurrency: Bool?, issuerId: Int64?, issuerName: String?, type: Int?, limitSetId: Int64?, hash: String?, spareFields: SpareFields?, cardType: Int?, cardNumber: String, securityNumber: String?, yearExpiry: Int?, monthExpiry: Int?, cardHolderName: String?, cardIssueNumber: Int?, displayNumber: String?) {
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
        self.cardType = cardType
        self.cardNumber = cardNumber
        self.securityNumber = securityNumber
        self.yearExpiry = yearExpiry
        self.monthExpiry = monthExpiry
        self.cardHolderName = cardHolderName
        self.cardIssueNumber = cardIssueNumber
        self.displayNumber = displayNumber
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
        case cardType
        case cardNumber
        case securityNumber
        case yearExpiry
        case monthExpiry
        case cardHolderName
        case cardIssueNumber
        case displayNumber
    }

}
