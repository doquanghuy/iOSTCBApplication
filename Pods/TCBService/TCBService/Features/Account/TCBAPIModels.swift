//
//  TCBAPIModels.swift
//  TCBService
//
//  Created by Duong Dinh on 11/19/20.
//

import Foundation
import Backbase

struct TCBCreateUserRequest: Codable {
    var username: String
    var password: String
    var firstName: String
    var lastName: String
    var email: String
    var enabled: String
    var requiredActions: [String]
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
        case firstName
        case lastName
        case email
        case enabled
        case requiredActions
    }
}

struct TCBResetPasswordRequest: Codable {
    
    var userId: String
    var type: String
    var value: String
    var temporary: Bool
}

struct TCBDeleteRequest {
    var userId: String
}

public struct SetupUserToDBSRequest {
    public var username: String
    public var password: String
}

public struct TCBAddUserAsSAAdminRequest {
    public var externalUserId: String
    public let externalServiceAgreementId: String = Backbase.dbsExternalServiceAgreementId
    
}

struct TCBAddUserAsSAAdminResponse: Codable {
    
    var action: String?
    var externalServiceAgreementId: String?
    var resourceId: String?
    var status: String?
    var errors: [String]?
    
}

struct TCBCreateArrangementRequest {
    
    var id: String
    var name: String
    var IBAN: String
    var bookedBalance: Double
    var availableBalance: Double
    var creditLimit: Double
    // default
    let legalEntityIds: [String] = ["Techcombank"]
    var productId: String = "p001"
    let alias: String =  "alias11"
    let BBAN: String =  "BBAN"
    let currency: String =  "EUR"
    let externalTransferAllowed: Bool =  true
    let urgentTransferAllowed: Bool =  false
    let accruedInterest: Double =  100.00
    let number: String =  "PANS"
    let principalAmount: Double =  100.4
    let currentInvestmentValue: Double =  100.5
    let BIC: String =  "BIC123"
    let bankBranchCode: String =  "bankBranchCode1"
}

struct TCBCreateArrangementResponse: Codable {
    var arrangementId: String?
    var message: String?
    //    var errors: [ErrorCreateArrangement]?
    
    enum CodingKeys: String, CodingKey {
        case arrangementId = "id"
        case message = "message"
    }
}

struct ErrorCreateArrangement: Codable {
    var message: String?
    var key: String?
}

struct TCBCreateFunctionGroupsRequest {
    
    var name: String
    var description: String
    var externalServiceAgreementId: String = Backbase.dbsExternalServiceAgreementId
    
}

struct TCBCreateFunctionGroupsResponse: Codable {
    var functionGroupId: String?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case functionGroupId = "id"
        case message = "message"
    }
}

struct TCBCreateDataGroupRequest {
    
    var name: String
    var description: String
    let serviceAgreementId: String = Backbase.dbsServiceAgreementId
    let type: String = "ARRANGEMENTS"
    var items: [String]
    
}

struct TCBCreateDataGroupResponse: Codable {
    var dataGroupId: String?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case dataGroupId = "id"
        case message = "message"
    }
}

struct TCBAssignPermissionRequest {
    var functionGroupId: String
    var dataGroupId: String
    var userInternalId: String
    
}

struct TCBAssignPermissionResponse: Codable {
    var message: String?
}

struct TCBMobileTransactionSalaryArrangementsRequest {
    var username: String
}

public struct ErrorEntity: Error, Codable {
    public var error: String
    public var errorDescription: String

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case errorDescription = "error_description"
    }
}
