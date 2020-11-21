//
//  AuditMessage.swift
//  Domain
//
//  Created by vuong on 11/16/20.
//

import Foundation

public struct AuditMessage: Codable {
    public let timestamp: String?
    public let eventCategory: String?
    public let objectType: String?
    public let eventAction: String?
    public let eventDescription: String?
    public let status: String?
}

public struct AuditMessageResponse: Codable {
    public let auditMessages: [AuditMessage]?
}
