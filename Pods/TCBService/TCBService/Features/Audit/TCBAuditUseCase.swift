//
//  TCBAuditUseCase.swift
//  TCBService
//
//  Created by vuong on 11/16/20.
//

import Foundation
import TCBDomain

class TCBAuditUseCase: AuditUseCase {
    private let client: TCBDBSClient

    init(client: TCBDBSClient) {
        self.client = client
    }
    
    func getAuditMessages(username: String, completion: @escaping TCBResponseCompletion<AuditMessageResponse>) {
        let request =  TCBAuditMessagesRequest(partialMatchAgainst: "username", username: username, orderBy: "timestamp", direction: "DESC")
        
        client.getAuditMessages(request: request) { (result) in
            completion(TCBDomain.TCBResult<AuditMessageResponse>.from(result))
        }
    }
}
