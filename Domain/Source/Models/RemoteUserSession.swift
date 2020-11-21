//
//  RemoteUserSession.swift
//  TCBPay
//
//  Created by Dinh Duong on 9/10/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import Foundation

typealias AuthToken = String

public struct RemoteUserSession: Codable {
    
    // MARK: - Properties
    let token: AuthToken
    
    // MARK: - Methods
    init(token: AuthToken) {
        self.token = token
    }
}

extension RemoteUserSession: Equatable {
    
    public static func == (lhs: RemoteUserSession, rhs: RemoteUserSession) -> Bool {
        return lhs.token == rhs.token
    }
}
