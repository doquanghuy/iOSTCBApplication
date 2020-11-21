//
//  OfflineSVA.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 10/2/20.
//

import Foundation

public struct OfflineSVA: Codable {

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
    public var balanceAmount: Int64?
    public var offlineSVAStatusId: Int?
    public var merchant: Int64?
    public var shared: Bool?
    public var svaCode: String
    public var lastSyncDate: Date?
    public var _description: String?
    public var lastUpdate: Date?
    public var lastUpdater: Int64?
    public var creationDate: Date?
    public var creator: Int64?
    public var _default: Bool?

    public init(_id: Int64?, customerId: Int64?, active: Bool?, status: Int?, currency: String?, multiCurrency: Bool?, issuerId: Int64?, issuerName: String?, type: Int?, limitSetId: Int64?, hash: String?, spareFields: SpareFields?, balanceAmount: Int64?, offlineSVAStatusId: Int?, merchant: Int64?, shared: Bool?, svaCode: String, lastSyncDate: Date?, _description: String?, lastUpdate: Date?, lastUpdater: Int64?, creationDate: Date?, creator: Int64?, _default: Bool?) {
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
        self.balanceAmount = balanceAmount
        self.offlineSVAStatusId = offlineSVAStatusId
        self.merchant = merchant
        self.shared = shared
        self.svaCode = svaCode
        self.lastSyncDate = lastSyncDate
        self._description = _description
        self.lastUpdate = lastUpdate
        self.lastUpdater = lastUpdater
        self.creationDate = creationDate
        self.creator = creator
        self._default = _default
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
        case balanceAmount
        case offlineSVAStatusId
        case merchant
        case shared
        case svaCode
        case lastSyncDate
        case _description = "description"
        case lastUpdate
        case lastUpdater
        case creationDate
        case creator
        case _default = "default"
    }

}
