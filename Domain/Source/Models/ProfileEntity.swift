//
//  ProfileEntity.swift
//  Domain
//
//  Created by Thuy Truong Quang on 10/28/20.
//

import Foundation

//"email_verified": false,
//"name": "Sergey Kargopolov",
//"preferred_username": "test123",
//"given_name": "Sergey",
//"family_name": "Kargopolov",
//"email": "test1111111211111@test.com"

public struct ProfileEntity: Error, Codable {
    public var userID: String
    public var emailVerified: Bool
    public var name: String
    public var preferredUsername: String
    public var givenName: String
    public var familyName: String
    public var email: String
    
    enum CodingKeys: String, CodingKey {
        case emailVerified = "email_verified"
        case name = "name"
        case preferredUsername = "preferred_username"
        case givenName = "given_name"
        case familyName = "family_name"
        case email = "email"
        case userID = "sub"
    }
}
