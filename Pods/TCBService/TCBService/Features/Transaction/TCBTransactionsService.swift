//
//  TCBTransactionsService.swift
//  TCBService
//
//  Created by duc on 10/19/20.
//

import TransactionsClient
import TCBDomain

protocol TCBTransactionsService {
    func fetchTransactions(_ completion: @escaping TCBResponseCompletion<[TCBDomain.TransactionItem]>)
    func getIBANfromUserAccountName(useAccountName: String, completion: @escaping TCBResponseCompletion<TCBCard?>)

}
