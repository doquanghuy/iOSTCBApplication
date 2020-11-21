//
//  Bank.swift
//  FastMobile
//
//  Created by duc on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

public struct Bank: Codable {
    public let name: String
    public let logo: String
    public let description: String
    public let code: String?
    public let bic: String?
    public let address: String?
    public let country: String?

    public init(name: String,
                logo: String,
                description: String,
                code: String? = nil,
                bic: String? = nil,
                address: String? = nil,
                country: String? = nil) {
        self.name = name
        self.logo = logo
        self.description = description
        self.code = code
        self.bic = bic
        self.address = address
        self.country = country
    }
}
