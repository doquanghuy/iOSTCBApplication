//
//  TCBRecentActivityUseCase.swift
//  TCBService
//
//  Created by duc on 10/18/20.
//

import TCBDomain
import TransactionsClient

class TCBRecentActivityUseCase: RecentActivityUseCase {
    private let client: TCBTransactionsService

    init(client: TCBTransactionsService) {
        self.client = client
    }
    
    func retrieveRecentActivities(completion: @escaping TCBResponseCompletion<[TCBDomain.TransactionItem]>) {
        client.fetchTransactions(completion)
    }
    
    func getIBANfromUserAccountName(useAccountName: String, completion: @escaping TCBResponseCompletion<TCBCard?>) {
        client.getIBANfromUserAccountName(useAccountName: useAccountName, completion: completion)
    }
}
