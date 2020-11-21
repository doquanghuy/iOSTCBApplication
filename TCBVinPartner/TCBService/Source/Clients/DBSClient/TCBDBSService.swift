//
//  TCBDBSService.swift
//  TCBService
//
//  Created by Huy Van Nguyen on 11/5/20.
//

import Domain

struct TCBDBSLoginRequest {
    var username: String
    var password: String
    var submit: String
}

struct DBSProduct: Codable {
    let bookedBalance: String
    let availableBalance: String
    let currency: String
}

protocol TCBDBSService {
    func importIdentityUserToDBS(request: TCBImportIdentityUserToDBSRequest, completion: @escaping (TCBResult<TCBImportIdentityUserToDBSResponse>) -> ())
//    func login(request: TCBDBSLoginRequest, completion: @escaping (TCBResult<Bool>) -> Void)
//    func getBalance(for username: String, completion: @escaping (TCBResult<String>) -> Void)
}

struct TCBImportIdentityUserToDBSRequest {
    var externalId: String
    var legalEntityInternalId: String
}

struct TCBAuditMessagesRequest {
    var partialMatchAgainst: String
    var username: String
    var orderBy: String
    var direction: String
}
