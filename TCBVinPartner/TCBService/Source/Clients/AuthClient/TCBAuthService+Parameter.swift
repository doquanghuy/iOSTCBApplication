//
//  TCBAuthService+Parameter.swift
//  TCBService
//
//  Created by Huy TO. Nguyen Van on 10/30/20.
//

enum Parameter {
    case accessTokenUser
    case refreshTokenUser
    case accessTokenAdmin
    case refreshTokenAdmin
    case accessTokenDBS
    case refreshTokenDBS
    case password
    case securityAdminConsole
    case refreshToken
    case environment
    
    var value: String {
        switch self {
        case .accessTokenUser:
            return "access_token_user"
        case .refreshTokenUser:
            return "refresh_token_user"
        case .accessTokenAdmin:
            return "access_token_admin"
        case .refreshTokenAdmin:
            return "refresh_token_admin"
        case .accessTokenDBS:
            return "access_token_dbs"
        case .refreshTokenDBS:
            return "refresh_token_dbs"
        case .password:
            return "password"
        case .securityAdminConsole:
            return "security-admin-console"
        case .refreshToken:
            return "refresh_token"
        case .environment:
            return "Environment"
        }
    }
}
