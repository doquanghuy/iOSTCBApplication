//
//  TCBTransactionsService.swift
//  TCBService
//
//  Created by duc on 10/19/20.
//

import TransactionsClient
import Domain

protocol TCBTransactionsService {
    func fetchTransactions(_ completion: @escaping TCBResponseCompletion<[Domain.TransactionItem]>)
    func getIBANfromUserAccountName(useAccountName: String, completion: @escaping TCBResponseCompletion<TCBCard?>)

}
