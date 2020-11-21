//
//  TCBDBSService.swift
//  TCBService
//
//  Created by Huy Van Nguyen on 11/5/20.
//

import TCBDomain

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
