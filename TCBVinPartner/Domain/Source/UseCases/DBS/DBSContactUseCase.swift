//
//  DBSContactUseCase.swift
//  Domain
//
//  Created by Pham Thanh Hoa on 11/16/20.
//

import Foundation

public protocol DBSContactUseCase {
    func fetchContactList(completion: @escaping TCBResponseCompletion<[Contact]>)
    func addContact(accountName: String,
                    accountNumber: String,
                    name: String,
                    bank: Bank?,
                    completion: ((String?, Error?) -> Void)?)
    func deleteContact(_ contactId: String, completion: ((Bool?, Error?) -> Void)?)
}
