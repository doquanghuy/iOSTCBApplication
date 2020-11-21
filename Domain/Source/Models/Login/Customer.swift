//
//  Customer.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 9/30/20.
//

import Foundation

public struct Customer: TCBAutoCodable {

    public var _id: Int64?
    public var parentId: Int64?
    public var orgUnitId: String?
    public var blackListReason: Int?
    public var active: Bool?
    public var test: Bool?
    public var displayName: String?
    public var timeZone: String?
    public var language: String?
    public var country: String?
    public var securityQuestion: String?
    public var securityAnswer: String?
    //public var dateOfBirth: Date?
    public var dateOfBirth: Int?
    public var riskCategoryId: Int?
    public var customerTypeId: Int?
    public var cancellationReasonId: Int?
    public var referralCode: String?
    public var txnText: String?
    public var feeVatPercentage: Float32?
    public var feeSetId: Int64?
    public var limitSetId: Int64?
    public var txnReceiptModeId: Int?
    public var created: Int?
    public var spareFields: SpareFields?

    public init() {}

    public init(_id: Int64?, parentId: Int64?, orgUnitId: String?, blackListReason: Int?, active: Bool?, test: Bool?, displayName: String?, timeZone: String?, language: String?, country: String?, securityQuestion: String?, securityAnswer: String?, dateOfBirth: Int?, riskCategoryId: Int?, customerTypeId: Int?, cancellationReasonId: Int?, referralCode: String?, txnText: String?, feeVatPercentage: Float32?, feeSetId: Int64?, limitSetId: Int64?, txnReceiptModeId: Int?, created: Int?, spareFields: SpareFields?) {
        self._id = _id
        self.parentId = parentId
        self.orgUnitId = orgUnitId
        self.blackListReason = blackListReason
        self.active = active
        self.test = test
        self.displayName = displayName
        self.timeZone = timeZone
        self.language = language
        self.country = country
        self.securityQuestion = securityQuestion
        self.securityAnswer = securityAnswer
        self.dateOfBirth = dateOfBirth
        self.riskCategoryId = riskCategoryId
        self.customerTypeId = customerTypeId
        self.cancellationReasonId = cancellationReasonId
        self.referralCode = referralCode
        self.txnText = txnText
        self.feeVatPercentage = feeVatPercentage
        self.feeSetId = feeSetId
        self.limitSetId = limitSetId
        self.txnReceiptModeId = txnReceiptModeId
        self.created = created
        self.spareFields = spareFields
    }

    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case parentId = "parentId"
        case orgUnitId = "orgUnitId"
        case blackListReason = "blackListReason"
        case active = "active"
        case test = "test"
        case displayName = "displayName"
        case timeZone = "timeZone"
        case language = "language"
        case country = "country"
        case securityQuestion = "securityQuestion"
        case securityAnswer = "securityAnswer"
        case dateOfBirth = "dateOfBirth"
        case riskCategoryId = "riskCategoryId"
        case customerTypeId = "customerTypeId"
        case cancellationReasonId = "cancellationReasonId"
        case referralCode = "referralCode"
        case txnText = "txnText"
        case feeVatPercentage = "feeVatPercentage"
        case feeSetId = "feeSetId"
        case limitSetId = "limitSetId"
        case txnReceiptModeId = "txnReceiptModeId"
        case created = "created"
        case spareFields = "spareFields"
    }

}
