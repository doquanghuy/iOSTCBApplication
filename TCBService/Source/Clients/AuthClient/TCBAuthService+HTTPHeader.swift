//
//  TCBAuthService+HTTPHeader.swift
//  TCBService
//
//  Created by Huy TO. Nguyen Van on 10/30/20.
//

enum HTTPHeader {
    case contentType
    case accept
    case authorization
    case location
    
    var value: String {
        switch self {
        case .contentType:
            return "Content-Type"
        case .accept:
            return "Accept"
        case .authorization:
            return "Authorization"
        case .location:
            return "Location"
        }
    }
}

enum ContentType {
    case applicationXWWWFormURLEncoded
    case applicationJson
    
    var value: String {
        switch self {
        case .applicationXWWWFormURLEncoded:
            return "application/x-www-form-urlencoded"
        case .applicationJson:
            return "application/json"
        }
    }
}

enum Authorization {
    case bearer(_ accessToken: String)
    var value: String {
        switch self {
        case .bearer(let accessToken):
            return "bearer \(accessToken)"
        }
    }
}
