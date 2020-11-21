//
//  LoginCustomerRequest.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 9/30/20.
//

import Foundation

public struct LoginCustomerRequest: TCBAutoCodable {

    public var auditData: AuditDataType?
    public var unstructuredData: [KeyValue]?
    public var callback: String?
    public var origin: String?
    public var traceNo: String?
    public var _repeat: Bool?
    public var conversationId: String?
    public var sessionId: String?
    public var identification: String
    public var credential: String
    public var identificationType: Int?
    public var credentialType: Int?
    public var orgUnit: String?
    public var createPersistentLogin: Bool?
    public var allPrivilegesRequired: Bool?
    public var requiredPrivilege: [String]?

    public init(auditData: AuditDataType?, unstructuredData: [KeyValue]?, callback: String?, origin: String?, traceNo: String?, _repeat: Bool?, conversationId: String?, sessionId: String?, identification: String, credential: String, identificationType: Int?, credentialType: Int?, orgUnit: String?, createPersistentLogin: Bool?, allPrivilegesRequired: Bool?, requiredPrivilege: [String]?) {
        self.auditData = auditData
        self.unstructuredData = unstructuredData
        self.callback = callback
        self.origin = origin
        self.traceNo = traceNo
        self._repeat = _repeat
        self.conversationId = conversationId
        self.sessionId = sessionId
        self.identification = identification
        self.credential = credential
        self.identificationType = identificationType
        self.credentialType = credentialType
        self.orgUnit = orgUnit
        self.createPersistentLogin = createPersistentLogin
        self.allPrivilegesRequired = allPrivilegesRequired
        self.requiredPrivilege = requiredPrivilege
    }

    public enum CodingKeys: String, CodingKey {
        case auditData = "AuditData"
        case unstructuredData = "UnstructuredData"
        case callback
        case origin = "origin"
        case traceNo = "traceNo"
        case _repeat = "repeat"
        case conversationId
        case sessionId
        case identification = "identification"
        case credential = "credential"
        case identificationType = "identificationType"
        case credentialType = "credentialType"
        case orgUnit
        case createPersistentLogin
        case allPrivilegesRequired
        case requiredPrivilege
    }

}
