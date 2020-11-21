//
//  TCBAuthService.swift
//  TCBService
//
//  Created by duc on 10/18/20.
//

import TCBDomain

protocol TCBAuthService {
    func login(request: TCBLoginRequest, completion: @escaping (TCBResult<User>) -> ())
}

extension TCBAuthService {
    
}

struct TCBLoginRequest: Codable {
    var username: String
    var password: String
    var grantType: String
    var clientId: String
    
    init(username: String, password: String, grantType: String = Parameter.password.value, clientId: String = Parameter.securityAdminConsole.value) {
        self.username = username
        self.password = password
        self.grantType = grantType
        self.clientId = clientId
    }
    
    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case username
        case password
        case clientId = "client_id"
    }
}
