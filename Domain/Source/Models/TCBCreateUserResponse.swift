//
//  TCBCreateUserResponse.swift
//  Domain
//
//  Created by Huy TO. Nguyen Van on 10/30/20.
//

public struct TCBCreateUserResponse: Codable {
    public var errorMessage: String?
    public var userId: String?
    
    public init(_ userId: String? = nil,_ errorMessage: String? = nil) {
        self.userId = userId
        self.errorMessage = errorMessage
    }
}
