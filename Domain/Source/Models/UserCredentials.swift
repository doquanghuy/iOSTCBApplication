//
//  UserCredentials.swift
//  Domain
//
//  Created by vuong on 10/15/20.
//

import Foundation

public struct UserCredentials: Codable {
    public var email: String
    public var password: String

    public init (email: String, password: String) {
        self.email = email
        self.password = password
    }
}

