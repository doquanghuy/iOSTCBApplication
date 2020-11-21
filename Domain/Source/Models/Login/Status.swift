//
//  Status.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 9/30/20.
//

import Foundation

public struct Status: TCBAutoCodable {

    public var value: String?
    public var code: Int?

    public init(value: String?, code: Int?) {
        self.value = value
        self.code = code
    }
}
