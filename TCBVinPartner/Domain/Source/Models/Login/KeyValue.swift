//
//  KeyValue.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 9/30/20.
//

import Foundation

public struct KeyValue: TCBAutoCodable {

    public var key: String
    public var value: String?

    public init(key: String, value: String?) {
        self.key = key
        self.value = value
    }
    
    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case value = "Value"
    }
}
