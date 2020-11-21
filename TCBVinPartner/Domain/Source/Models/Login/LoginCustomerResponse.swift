//
//  LoginCustomerResponse.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 9/30/20.
//

import Foundation

public struct LoginCustomerResponse: TCBAutoCodable {

    public var unstructuredData: [KeyValue]?
    public var status: Status?
    public var conversationId: String?
    public var customer: Customer?
    public var sessionId: String?
    public var sessionTimeoutSeconds: Int?
    public var privileges: [String]?

    public init(unstructuredData: [KeyValue]?, status: Status?, conversationId: String?, customer: Customer?, sessionId: String?, sessionTimeoutSeconds: Int?, privileges: [String]?) {
        self.unstructuredData = unstructuredData
        self.status = status
        self.conversationId = conversationId
        self.customer = customer
        self.sessionId = sessionId
        self.sessionTimeoutSeconds = sessionTimeoutSeconds
        self.privileges = privileges
    }
    
    enum CodingKeys: String, CodingKey {
        case unstructuredData = "UnstructuredData"
        case status = "Status"
        case conversationId = "conversationId"
        case customer = "customer"
        case sessionId = "sessionId"
        case sessionTimeoutSeconds = "sessionTimeoutSeconds"
        case privileges = "privileges"
    }
}
