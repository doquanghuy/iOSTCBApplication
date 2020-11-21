//
//  Message.swift
//  Domain
//
//  Created by duc on 10/19/20.
//

import Foundation

public struct Message: Codable {
    public let title: String
    public let description: String
    public let iconName: String
    public let amount: String

    public init(title: String, description: String, iconName: String, amount: String) {
        self.title = title
        self.description = description
        self.iconName = iconName
        self.amount = amount
    }
}
