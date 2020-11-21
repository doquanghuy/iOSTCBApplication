//
//  Payment.swift
//  Domain
//
//  Created by Do Quang Huy on 11/10/20.
//

import Foundation

public struct PaymentInfo: Codable {
    public let identificationSender: String?
    public let schemeName: String?
    public let date: TimeInterval?
    public let type: String?
    public let amount: Double?
    public let currencyCode: String?
    public let receiverName: String?
    public let receiverIdentification: String?
    public let receiverScheme: String?
    public let receiverContactId: String?
    public let receiverId: String?
    public let receiverBankCode: String?
    public let receiverBankBIC: String?
    public let receiverBankName: String?
    public let receiverBankAddress: String?
    public let receiverBankCountry: String?
    public let message: String?
    public let targetCurrency: String?
    
    public init(identificationSender: String?,
                schemeName: String? = "ID",
                date: TimeInterval? = Date().timeIntervalSince1970,
                type: String? = "SEPA_CREDIT_TRANSFER",
                amount: Double?,
                currencyCode: String? = "EUR",
                receiverName: String?,
                receiverIdentification: String?,
                receiverScheme: String? = "IBAN",
                receiverContactId: String? = nil,
                receiverId: String? = nil,
                receiverBankCode: String? = nil,
                receiverBankBIC: String? = nil,
                receiverBankName: String? = nil,
                receiverBankAddress: String? = nil,
                receiverBankCountry: String? = nil,
                message: String? = nil,
                targetCurrency: String? = "EUR") {
        self.identificationSender = identificationSender
        self.schemeName = schemeName
        self.date = date
        self.type = type
        self.amount = amount
        self.currencyCode = currencyCode
        self.receiverName = receiverName
        self.receiverIdentification = receiverIdentification
        self.receiverScheme = receiverScheme
        self.receiverContactId = receiverContactId
        self.receiverId = receiverId
        self.receiverBankCode = receiverBankCode
        self.receiverBankBIC = receiverBankBIC
        self.receiverBankName = receiverBankName
        self.receiverBankAddress = receiverBankAddress
        self.receiverBankCountry = receiverBankCountry
        self.message = message
        self.targetCurrency = targetCurrency
    }
}

