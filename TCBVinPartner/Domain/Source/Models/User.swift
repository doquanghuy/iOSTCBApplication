//
//  User.swift
//  TCBPay
//
//  Created by Duong Dinh on 7/29/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import Foundation

public enum LoginStatus {
    case loggedIn
    case none
}

public enum UserError: Error {
    case noData
}

public struct LegacyUser: Equatable, Codable {
    
    // MARK: - Properties
    public let email: String
    public let password: String
    public let firstName: String
    public let lastName: String
    
    public init(email: String, password: String, firstName: String, lastName: String) {
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
    }
}

public struct User: Codable {
    public let name: String?
    public let avatarURL: String?
    public var accessToken: String?
    public var expiresIn: Int?
    public var refreshExpiresIn: Int?
    public var refreshToken: String?
    public var tokenType: String?
    public var notBeforePolicy: Int?
    public var sessionState: String?
    public var scope: String?
    public var error: String?
    public var errorDescription: String?
    
    public var firstName: String?
    public var lastName: String?
    public var email: String?
    public var enabled: String?
    public var requiredActions: [String]?
    
    public var userId: String?
    
    public var userCredentials: UserCredentials?
    
    public init(name: String? = nil, avatarURL: String? = nil, accessToken: String? = nil, expiresIn: Int? = nil, refreshExpiresIn: Int? = nil, refreshToken: String? = nil, tokenType: String? = nil, notBeforePolicy: Int? = nil, sessionState: String? = nil, scope: String? = nil, error: String? = nil, errorDescription: String? = nil, firstName: String? = nil, lastName: String? = nil, email: String? = nil, enabled: String? = nil, requiredActions: [String]? = nil, userId: String? = nil, userCredentials: UserCredentials? = nil) {
        self.name = name
        self.avatarURL = avatarURL
        self.accessToken = accessToken
        self.expiresIn = expiresIn
        self.refreshExpiresIn = refreshExpiresIn
        self.refreshToken = refreshToken
        self.tokenType = tokenType
        self.notBeforePolicy = notBeforePolicy
        self.sessionState = sessionState
        self.scope = scope
        self.error = error
        self.errorDescription = errorDescription
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.enabled = enabled
        self.requiredActions = requiredActions
        
        self.userId = userId
        
        self.userCredentials = userCredentials
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case avatarURL
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshExpiresIn = "refresh_expires_in"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case notBeforePolicy = "not-before-policy"
        case sessionState = "session_state"
        case scope
        case error
        case errorDescription = "error_description"
        case firstName
        case lastName
        case email
        case enabled
        case requiredActions
        case userCredentials
        case userId
    }
}
