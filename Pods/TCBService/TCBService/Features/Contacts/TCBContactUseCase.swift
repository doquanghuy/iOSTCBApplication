//
//  TCBContactUseCase.swift
//  Domain
//
//  Created by Pham Thanh Hoa on 11/16/20.
//

import Foundation
import TCBDomain

class TCBContactUseCase: DBSContactUseCase {
    private let client: TCBDBSContactService

    init(client: TCBDBSContactService) {
        self.client = client
    }
    
    func fetchContactList(completion: @escaping TCBResponseCompletion<[Contact]>) {
        client.fetchContactList(completion: completion)
    }
    
    func addContact(accountName: String,
                    accountNumber: String,
                    name: String,
                    bank: Bank?,
                    completion: ((String?, Error?) -> Void)?) {
        client.addContact(accountName: accountName,
                          accountNumber: accountNumber,
                          name: name,
                          bank: bank,
                          completion: completion)
    }
    
    func deleteContact(_ contactId: String, completion: ((Bool?, Error?) -> Void)?) {
        client.deleteContact(contactId, completion: completion)
    }
}
