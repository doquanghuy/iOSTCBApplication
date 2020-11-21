//
//  TCBDBSContactService.swift
//  Domain
//
//  Created by Pham Thanh Hoa on 11/16/20.
//

import Foundation
import TCBDomain
import ContactsClient
import Accounts

public protocol TCBDBSContactService {
    func fetchContactList(completion: @escaping TCBResponseCompletion<[Contact]>)
    func addContact(accountName: String,
                    accountNumber: String,
                    name: String,
                    bank: Bank?,
                    completion: ((String?, Error?) -> Void)?)
    func deleteContact(_ contactId: String, completion: ((Bool?, Error?) -> Void)?)
}

class TCBDBSContactClient: NSObject {
    private let client: ContactsClient
    
    override init() {
        let provider = TCBContactDataProvider(type: .remote(path: "/api"))
        client = ContactsClient(dataProvider: provider)
        super.init()
    }
    
    private func createBBContact(from accountName: String,
                                 accountNumber: String,
                                 name: String,
                                 bank: Bank? = nil) -> BBContact {
        let accountInfo = MutableAccount()
        accountInfo.accountNumber = accountNumber
        accountInfo.iban = accountNumber
        accountInfo.name = accountName
        accountInfo.bankName = bank?.name
        accountInfo.bankCode = bank?.code
        accountInfo.bankCountry = bank?.country
        accountInfo.bankAddressLine1 = bank?.address
        
        let newContact = BBMutableContact()
        newContact.accounts = [accountInfo]
        newContact.name = name
        
        return newContact
    }
}

final class TCBContactDataProvider: TCBDataProvider {}

extension ContactsClient: BBAppClient {
    typealias EnvironmentDataProvider = TCBContactDataProvider
}

extension TCBDBSContactClient: TCBDBSContactService {
    func fetchContactList(completion: @escaping TCBResponseCompletion<[Contact]>) {
        let dbs = Backbase.configuration().custom["dbs"] as? [String: String]
        let saId = dbs?["serviceAgreementId"] ?? ""
        client.retrieveContacts(["saId": saId]) { (contacts, error) in
            if let error = error {
                completion(.error(error))
                return
            }

            let contactList = contacts?.compactMap({ item -> Contact in
                let accounts = item.accounts.compactMap { account -> TCBDomain.Account? in
                    return TCBDomain.Account(id: "",
                                          accountNumber: account.iban ?? "",
                                          name: account.name ?? "",
                                          balance: 0.0,
                                          bank: Bank(name: account.bankName ?? "", logo: "", description: ""))
                }

                return Contact(id: item.identifier,
                                      name: item.name,
                                      accounts: accounts)
            })

            completion(.success(contactList))
        }
    }
    
    func addContact(accountName: String,
                    accountNumber: String,
                    name: String,
                    bank: Bank? = nil,
                    completion: ((String?, Error?) -> Void)?) {
        let contact = createBBContact(from: accountName,
                                      accountNumber: accountNumber,
                                      name: name,
                                      bank: bank)
        client.create(with: contact, completionHandler: completion)
    }
    
    func deleteContact(_ contactId: String, completion: ((Bool?, Error?) -> Void)?) {
        client.deleteContact(byId: contactId, completionHandler: completion)
    }
}
