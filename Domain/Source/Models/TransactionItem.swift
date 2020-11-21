//
//  TransactionItem.swift
//  Domain
//
//  Created by Do Quang Huy on 11/10/20.
//

import Foundation

public struct TransactionItem: Codable {
    public let id: String
    public let receiverName: String?
    public let amount: Double?
    public let description: String?
    public let receiverBankName: String?
    public let currency: String
    public let type: String
    public let bookingDate: Date
    public let receiverAccount: String?
    
    public init(id: String, receiverName: String?, amount: Double?, description: String?, receiverBankName: String?, currency: String, type: String, receiverAccount: String?) {
        self.id = id
        self.receiverName = receiverName
        self.amount = amount
        self.receiverBankName = receiverBankName
        self.currency = currency
        self.type = type
        self.receiverAccount = receiverAccount
        // Format of description from API: "2020-11-13 04:39:09|okok"
        self.bookingDate = description?.components(separatedBy: "|").first?.date(withFormat: "yyyy-MM-dd HH:mm:ss") ?? Date()
        self.description = description?.components(separatedBy: "|").last
        
    }
}
