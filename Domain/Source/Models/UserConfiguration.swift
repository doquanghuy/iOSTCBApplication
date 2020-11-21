//
//  UserConfiguration.swift
//  Domain
//
//  Created by Thuy Truong Quang on 10/30/20.
//

import Foundation

public struct UserConfiguration: Codable {
    public init() {}
    public var numFailures: Int = 0
    public var disabled: Bool = false
}
