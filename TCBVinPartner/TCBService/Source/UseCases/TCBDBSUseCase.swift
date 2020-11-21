//
//  TCBDBSUseCase.swift
//  TCBService
//
//  Created by Huy Van Nguyen on 11/5/20.
//

import Domain
import Backbase

class TCBDBSUseCase: DBSUseCase {
    private let dbsClient: TCBDBSService

    init(dbsClient: TCBDBSService) {
        self.dbsClient = dbsClient
    }
    
    func importIdentityUserToDBS(with username: String, completion: @escaping TCBResponseCompletion<TCBImportIdentityUserToDBSResponse>) {
        let customConfig = Backbase.configuration().custom
        let dbs = customConfig?["dbs"] as? Dictionary<String, String>
        let legalEntityInternalId = dbs?["legalEntityInternalId"]
        let request = TCBImportIdentityUserToDBSRequest(externalId: username, legalEntityInternalId: legalEntityInternalId ?? "")
        dbsClient.importIdentityUserToDBS(request: request) { (result) in
            completion(Domain.TCBResult<TCBImportIdentityUserToDBSResponse>.from(result))
        }
    }
}
