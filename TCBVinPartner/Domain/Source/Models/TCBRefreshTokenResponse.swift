//
//  TCBRefreshTokenResponse.swift
//  Domain
//
//  Created by Huy TO. Nguyen Van on 10/30/20.
//

public struct TCBRefreshTokenResponse: Codable {
    public var error: String?
    public var errorDescription: String?
    public var accessToken: String?
    public var expiresIn: Int?
    public var refreshExpiresIn: Int?
    public var refreshToken: String?
    public var tokenType: String?
    public var notBeforePolicy: Int?
    public var sessionState: String?
    public var scope: String?
    
    enum CodingKeys: String, CodingKey {
        case error
        case errorDescription = "error_description"
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshExpiresIn = "refresh_expires_in"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case notBeforePolicy = "not-before-policy"
        case sessionState = "session_state"
        case scope
    }
    
}
