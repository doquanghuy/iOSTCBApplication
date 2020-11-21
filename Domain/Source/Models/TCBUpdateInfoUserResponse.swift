//
//  TCBUpdateInfoUserResponse.swift
//  Domain
//
//  Created by Nguyen Van Huy on 2020/11/01.
//

public struct TCBUpdateInfoUserResponse: Codable {
//    public var error: String?
    public var message: String?
    
    public init(message: String? = nil) {
        self.message = message
    }
}
