//
//  SVA.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 10/2/20.
//

import Foundation

public struct SVA: Codable {

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
    public var creditBalance: Int64?
    public var creditReserved: Int64?
    public var debitBalance: Int64?
    public var debitReserved: Int64?
    public var lastBookingDate: Date?
    public var lastSvaBookingId: Int64?
    public var maxBalance: Int64?
    public var minBalance: Int64?
    public var refundInTransaction: Bool?
    public var refundAbsoluteAmount: Int64?
    public var refundPaymentInstrumentId: Int64?
    public var refundTargetAmount: Int64?
    public var refundThreshold: Int64?

    public init(_id: Int64?, customerId: Int64?, active: Bool?, status: Int?, currency: String?, multiCurrency: Bool?, issuerId: Int64?, issuerName: String?, type: Int?, limitSetId: Int64?, hash: String?, spareFields: SpareFields?, creditBalance: Int64?, creditReserved: Int64?, debitBalance: Int64?, debitReserved: Int64?, lastBookingDate: Date?, lastSvaBookingId: Int64?, maxBalance: Int64?, minBalance: Int64?, refundInTransaction: Bool?, refundAbsoluteAmount: Int64?, refundPaymentInstrumentId: Int64?, refundTargetAmount: Int64?, refundThreshold: Int64?) {
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
        self.creditBalance = creditBalance
        self.creditReserved = creditReserved
        self.debitBalance = debitBalance
        self.debitReserved = debitReserved
        self.lastBookingDate = lastBookingDate
        self.lastSvaBookingId = lastSvaBookingId
        self.maxBalance = maxBalance
        self.minBalance = minBalance
        self.refundInTransaction = refundInTransaction
        self.refundAbsoluteAmount = refundAbsoluteAmount
        self.refundPaymentInstrumentId = refundPaymentInstrumentId
        self.refundTargetAmount = refundTargetAmount
        self.refundThreshold = refundThreshold
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
        case creditBalance
        case creditReserved
        case debitBalance
        case debitReserved
        case lastBookingDate
        case lastSvaBookingId
        case maxBalance
        case minBalance
        case refundInTransaction
        case refundAbsoluteAmount
        case refundPaymentInstrumentId
        case refundTargetAmount
        case refundThreshold
    }

}
