//
//  TCBResetPasswordResponse.swift
//  Domain
//
//  Created by Huy TO. Nguyen Van on 10/30/20.
//

public struct TCBResetPasswordResponse: Codable {
    public var error: String?
    public var errorDescription: String?
    
    public init(error: String? = nil, errorDescription: String? = nil) {
        self.error = error
        self.errorDescription = errorDescription
    }
    
    enum CodingKeys: String, CodingKey {
        case error
        case errorDescription = "error_description"
    }
}
