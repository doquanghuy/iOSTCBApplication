//
//  TCBTransactionsClient.swift
//  TCBService
//
//  Created by duc on 10/16/20.
//


import TransactionsClient
import TCBDomain

class TCBTransactionsClient {
    private let client: TransactionsClient

    init() {
        let provider = TCBTransactionsDataProvider(type: .remote(path: "/api"))
        client = TransactionsClient(dataProvider: provider)
    }
}

extension TCBTransactionsClient: TCBTransactionsService {
    func fetchTransactions(_ completion: @escaping TCBResponseCompletion<[TCBDomain.TransactionItem]>) {
        let params: [String: String] = [
            "orderBy": "bookingDate",
            "direction": "DESC",
        ]
        client.retrieveTransactions(withParams: params) { (transactions, error) in
            if let transactions = transactions {
                let res = transactions.compactMap({ (transaction) -> TCBDomain.TransactionItem in
                    return TCBDomain.TransactionItem(id: transaction.identifier, receiverName: transaction.counterPartyName, amount: transaction.transactionAmountCurrency?.amount?.doubleValue, description: transaction.desc, receiverBankName: transaction.counterPartyBankName, currency: transaction.transactionAmountCurrency?.currencyCode ?? "", type: transaction.type, receiverAccount: transaction.counterPartyAccountNumber)
                })
                completion(.success(res))
            } else {
                completion(.error(error!))
            }
        }
    }
    
    func getIBANfromUserAccountName(useAccountName: String, completion: @escaping TCBResponseCompletion<TCBCard?>) {
        TCBHTTPIdentityAuthClient().lookupAccountInfo(name: useAccountName) { (result) in
            switch result {
            case let .success(cards):
                completion(.success(cards?.first))
            case let .error(error):
                completion(.error(error))
            }
        }
    }
}

// MARK: - Backbase TransactionsClient class extension
extension TransactionsClient: BBAppClient {
    typealias EnvironmentDataProvider = TCBTransactionsDataProvider
}
