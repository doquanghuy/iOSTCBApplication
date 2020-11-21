//
//  ExternalAccount.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 10/2/20.
//

import Foundation

public struct ExternalAccount: Codable {

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
    public var id1: String?
    public var id2: String?
    public var id3: String?
    public var id4: String?
    public var id5: String?
    public var id6: String?
    public var id7: String?
    public var id8: String?

    public init(_id: Int64?, customerId: Int64?, active: Bool?, status: Int?, currency: String?, multiCurrency: Bool?, issuerId: Int64?, issuerName: String?, type: Int?, limitSetId: Int64?, hash: String?, spareFields: SpareFields?, id1: String?, id2: String?, id3: String?, id4: String?, id5: String?, id6: String?, id7: String?, id8: String?) {
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
        self.id1 = id1
        self.id2 = id2
        self.id3 = id3
        self.id4 = id4
        self.id5 = id5
        self.id6 = id6
        self.id7 = id7
        self.id8 = id8
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
        case id1
        case id2
        case id3
        case id4
        case id5
        case id6
        case id7
        case id8
    }

}
