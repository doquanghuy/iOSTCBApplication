//
//  TCBCard.swift
//  Domain
//
//  Created by Duong Dinh on 11/11/20.
//

import Foundation

public struct TCBCard: Codable {
    public let productKindName: String
    public let productId: String
    public let productTypeName: String
    public let externalArrangementId: String
    public let name: String
    public let iban: String
    public let currency: String
    public let number: String
    public let bic: String
    
    private enum CodingKeys: String, CodingKey {
        case productKindName
        case productId
        case productTypeName
        case externalArrangementId
        case name
        case iban = "IBAN"
        case currency
        case number
        case bic = "BIC"
    }
}
