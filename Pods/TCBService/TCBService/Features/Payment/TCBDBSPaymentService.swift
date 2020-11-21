//
//  TCBDBSPaymentService.swift
//  Domain
//
//  Created by Do Quang Huy on 11/9/20.
//

import PaymentOrderClient
import TCBDomain

public protocol TCBDBSPaymentService {
    func fetchBalanceHistory(_ completion: @escaping TCBResponseCompletion<[Balance]>)
    func makePayment(paymentInfo: PaymentInfo, completion: @escaping TCBResponseCompletion<Balance>)
    func getPayment(paymentId: String, completion: @escaping TCBResponseCompletion<Balance?>)
}

class TCBDBSPaymentClient {
    private let client: PaymentOrderClient
    
    init() {
        let provider = TCBPaymentDataProvider(type: .remote(path: "/api"))
        client = PaymentOrderClient(dataProvider: provider)
    }
}

extension TCBDBSPaymentClient: TCBDBSPaymentService {
    func fetchBalanceHistory(_ completion: @escaping TCBResponseCompletion<[Balance]>) {
        client.retrievePaymentOrders(withParameters: nil) { (payments, error) in
            if let payments = payments {
                var balances = [Balance]()
                for balance in payments {
                    let res = Balance(id: balance.identifier, receiverName: balance.transferTransactionInformation?.counterparty?.name, amount: balance.transferTransactionInformation?.instructedAmount.amount?.doubleValue ?? 0.0, currency: balance.transferTransactionInformation?.instructedAmount.currencyCode, message: balance.transferTransactionInformation?.messageToBank, status: balance.status.rawValue)
                    balances.append(res)
                }
                completion(.success(balances))
            } else {
                completion(.error(error!))
            }
        }
    }
    
    func makePayment(paymentInfo: PaymentInfo, completion: @escaping TCBResponseCompletion<Balance>) {
        let senderIdentification = BBIdentification(identification: paymentInfo.identificationSender ?? "", schemeName: BBSchemeName(rawValue: paymentInfo.schemeName ?? ""))
        let origiantorAccount = BBAccountIdentification(identification: senderIdentification)
        let instructionPriority = BBInstructionPriority.norm
        let paymentMode = BBPaymentMode.single
        _ = BBPostalAddress(addressLine1: paymentInfo.receiverBankAddress, addressLine2: nil, streetName: nil, postCode: nil, town: nil, countrySubDivision: nil, country: paymentInfo.receiverBankCountry)
        let schemeName = paymentInfo.receiverScheme == "IBAN" ? BBSchemeName.IBAN : (paymentInfo.receiverScheme == "ID" ? BBSchemeName.ID : BBSchemeName.BBAN)
        let counterpartyAccount = BBInitiateCounterpartyAccount(identification: BBIdentification(identification: paymentInfo.receiverIdentification!, schemeName: schemeName))
        let currency = BBCurrency(amount: NSDecimalNumber(decimal: Decimal(paymentInfo.amount!)), currencyCode: paymentInfo.currencyCode!)
        let counterParty = BBInvolvedParty(name: paymentInfo.receiverName!, postalAddress: nil)
        let counterPartyBank = BBBank(bankBranchCode: paymentInfo.receiverBankCode, name: paymentInfo.receiverBankName, postalAddress: BBPostalAddress(addressLine1: paymentInfo.receiverBankAddress, addressLine2: nil, streetName: nil, postCode: nil, town: nil, countrySubDivision: nil, country: paymentInfo.receiverBankCountry), bic: paymentInfo.receiverBankBIC)
        let transferTransaction =
            BBInitiateTransaction(instructedAmount: currency, counterparty: counterParty, counterpartyAccount: counterpartyAccount, counterpartyBank: counterPartyBank, correspondentBank: nil, intermediaryBank: nil, messageToBank: nil, targetCurrency: paymentInfo.targetCurrency, remittanceInformation: paymentInfo.message, endToEndIdentification: nil)
        let initiatePaymentOrder = BBInitiatePaymentOrder(requestedExecutionDate: Date(), batchBooking: true, originatorAccount: origiantorAccount, instructionPriority: instructionPriority, paymentMode: paymentMode, paymentType: paymentInfo.type, schedule: nil, transferTransactionInformation: transferTransaction, approved: nil)
        client.createPaymentOrder(with: initiatePaymentOrder) { (response, error) in
            if let response = response {
                let balance = Balance(id: response.identifier, receiverName: paymentInfo.receiverName, amount: paymentInfo.amount, currency: paymentInfo.currencyCode, message: paymentInfo.message, status: response.status.rawValue)
                completion(.success(balance))
            } else {
                completion(.error(error!))
            }
        }
    }
    
    func getPayment(paymentId: String, completion: @escaping TCBResponseCompletion<Balance?>) {
        self.fetchBalanceHistory { (response) in
            switch response {
            case let .success(balances):
                let balance = balances?.filter {$0.id == paymentId}.first
                completion(.success(balance))
                break
            case let .error(error):
                completion(.error(error))
                break
            }
        }
    }
}

final class TCBPaymentDataProvider: TCBDataProvider {}

extension PaymentOrderClient: BBAppClient {
    typealias EnvironmentDataProvider = TCBPaymentDataProvider
}
