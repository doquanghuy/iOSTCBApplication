//
//  ProductUserCase.swift
//  Domain
//
//  Created by Do Quang Huy on 11/9/20.
//

import Foundation

public protocol PaymentUseCase {
    func fetchPaymentList(completion: @escaping TCBResponseCompletion<[Balance]>)
    func makePayment(paymentInfo: PaymentInfo, completion: @escaping TCBResponseCompletion<Balance>)
    func getPaymentInfo(paymentId: String, completion: @escaping TCBResponseCompletion<Balance?>)
}
