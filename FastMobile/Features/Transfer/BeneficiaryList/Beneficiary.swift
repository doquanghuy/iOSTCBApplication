//
//  Beneficiary.swift
//  FastMobile
//
//  Created by Dinh Duong on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

struct Beneficiary: Equatable, Codable {
    let accountName: String
    let bankName: String
    let accountId: String
    let isFavorited: Bool
    let bankIcon: String
    let receiver: Receiver?
    let name: String?
    let contactId: String?
}

public struct Receiver: Equatable, Codable {
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
}
