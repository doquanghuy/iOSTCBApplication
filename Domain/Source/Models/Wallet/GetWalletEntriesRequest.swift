//
//  GetWalletEntriesRequest.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 10/2/20.
//

import Foundation

public struct GetWalletEntriesRequest: Codable {

    public var auditData: AuditDataType?
    public var unstructuredData: [KeyValue]?
    public var callback: String?
    public var origin: String?
    public var traceNo: String?
    public var _repeat: Bool?
    public var conversationId: String?
    public var sessionId: String?
    public var customerId: Int64?
    public var paymentInstrumentTypeFilter: Int?
    public var paymentInstrumentClassFilter: Int?

    public init(auditData: AuditDataType?, unstructuredData: [KeyValue]?, callback: String?, origin: String?, traceNo: String?, _repeat: Bool?, conversationId: String?, sessionId: String?, customerId: Int64?, paymentInstrumentTypeFilter: Int?, paymentInstrumentClassFilter: Int?) {
        self.auditData = auditData
        self.unstructuredData = unstructuredData
        self.callback = callback
        self.origin = origin
        self.traceNo = traceNo
        self._repeat = _repeat
        self.conversationId = conversationId
        self.sessionId = sessionId
        self.customerId = customerId
        self.paymentInstrumentTypeFilter = paymentInstrumentTypeFilter
        self.paymentInstrumentClassFilter = paymentInstrumentClassFilter
    }

    public enum CodingKeys: String, CodingKey {
        case auditData = "AuditData"
        case unstructuredData = "UnstructuredData"
        case callback
        case origin
        case traceNo
        case _repeat = "repeat"
        case conversationId
        case sessionId
        case customerId
        case paymentInstrumentTypeFilter
        case paymentInstrumentClassFilter
    }

}
