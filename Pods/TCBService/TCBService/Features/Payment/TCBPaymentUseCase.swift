//
//  TCBPaymentUseCase.swift
//  TCBService
//
//  Created by Do Quang Huy on 11/9/20.
//

import Foundation
import TCBDomain

class TCBPaymentUseCase: PaymentUseCase {
    private let client: TCBDBSPaymentService

    init(client: TCBDBSPaymentService) {
        self.client = client
    }

    func fetchPaymentList(completion: @escaping TCBResponseCompletion<[Balance]>) {
        client.fetchBalanceHistory(completion)
    }
    
    func makePayment(paymentInfo: PaymentInfo, completion: @escaping TCBResponseCompletion<Balance>) {
        client.makePayment(paymentInfo: paymentInfo, completion: completion)
    }
    
    func getPaymentInfo(paymentId: String, completion: @escaping TCBResponseCompletion<Balance?>) {
        client.getPayment(paymentId: paymentId, completion: completion)
    }
}
