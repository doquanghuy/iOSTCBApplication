//
//  Contact.swift
//  Domain
//
//  Created by Pham Thanh Hoa on 11/16/20.
//

import Foundation

public struct Contact: Codable {
    public let id: String
    public let name: String
    public let accounts: [Account]
    public let accessContextScope: String
    public let imageUri: URL?
    
    public init(id: String,
                name: String,
                accounts: [Account],
                accessContextScope: String = "USER",
                imageUri: URL? = nil) {
        self.id = id
        self.name = name
        self.accounts = accounts
        self.accessContextScope = accessContextScope
        self.imageUri = imageUri
    }
}
