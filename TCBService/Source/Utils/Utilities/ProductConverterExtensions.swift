//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import ProductsClient

final class CurrentAccountConverter: NSObject, BBProductConverter {
    func convert(_ products: [BBBaseProduct], withTypeIdentifier typeIdentifier: String?) -> [RecipientModel] {
        var recipients: [RecipientModel] = []
        guard let products = products as? [BBCurrentAccount] else { return recipients }
        for product in products {
            let recipient = RecipientModel()
            recipient.objectId = product.identifier
            recipient.accountName = product.productName
            recipient.typeIdentifier = typeIdentifier
            recipient.objectType = product.className
            recipient.rawString = product.jsonString()
            recipient.balance = product.bookedBalance?.stringValue
            recipient.currency = product.currency
            recipient.accountNumber = IBANFormatter.formatIBAN(product.iban)
            recipients.append(recipient)
        }
        return recipients
    }
}

final class SavingsAccountConverter: NSObject, BBProductConverter {
    func convert(_ products: [BBBaseProduct], withTypeIdentifier typeIdentifier: String?) -> [RecipientModel] {
        var recipients: [RecipientModel] = []
        guard let products = products as? [BBSavingsAccount] else { return recipients }
        for product in products {
            let recipient = RecipientModel()
            recipient.objectId = product.identifier
            recipient.accountName = product.productName
            recipient.typeIdentifier = typeIdentifier
            recipient.objectType = product.className
            recipient.rawString = product.jsonString()
            recipient.balance = product.bookedBalance?.stringValue
            recipient.currency = product.currency
            recipient.accountNumber = IBANFormatter.formatIBAN(product.iban)
            recipients.append(recipient)
        }
        return recipients
    }
}

final class DebitCardConverter: NSObject, BBProductConverter {
    func convert(_ products: [BBBaseProduct], withTypeIdentifier typeIdentifier: String?) -> [RecipientModel] {
        var recipients: [RecipientModel] = []
        guard let products = products as? [BBDebitCard] else { return recipients }
        for product in products {
            let recipient = RecipientModel()
            recipient.objectId = product.identifier
            recipient.accountName = product.productName
            recipient.typeIdentifier = typeIdentifier
            recipient.objectType = product.className
            recipient.rawString = product.jsonString()
            recipient.accountNumber = product.number?.formatCardNumber()
            recipients.append(recipient)
        }
        return recipients
    }
}

final class CreditCardConverter: NSObject, BBProductConverter {
    func convert(_ products: [BBBaseProduct], withTypeIdentifier typeIdentifier: String?) -> [RecipientModel] {
        var recipients: [RecipientModel] = []
        guard let products = products as? [BBCreditCard] else { return recipients }
        for product in products {
            let recipient = RecipientModel()
            recipient.objectId = product.identifier
            recipient.accountName = product.productName
            recipient.typeIdentifier = typeIdentifier
            recipient.objectType = product.className
            recipient.rawString = product.jsonString()
            recipient.balance = product.bookedBalance?.stringValue
            recipient.currency = product.currency
            recipient.accountNumber = product.number?.formatCardNumber()
            recipients.append(recipient)
        }
        return recipients
    }
}

final class TermDepositConverter: NSObject, BBProductConverter {
    func convert(_ products: [BBBaseProduct], withTypeIdentifier typeIdentifier: String?) -> [RecipientModel] {
        var recipients: [RecipientModel] = []
        guard let products = products as? [BBTermDeposit] else { return recipients }
        for product in products {
            let recipient = RecipientModel()
            recipient.objectId = product.identifier
            recipient.accountName = product.productName
            recipient.typeIdentifier = typeIdentifier
            recipient.objectType = product.className
            recipient.rawString = product.jsonString()
            recipient.balance = product.principalAmount?.stringValue
            recipient.currency = product.currency
            #if RETAILSEPA
                recipient.accountNumber = IBANFormatter.formatIBAN(product.iban)
            #endif
            recipients.append(recipient)
        }
        return recipients
    }
}

final class InvestmentAccountConverter: NSObject, BBProductConverter {
    func convert(_ products: [BBBaseProduct], withTypeIdentifier typeIdentifier: String?) -> [RecipientModel] {
        var recipients: [RecipientModel] = []
        guard let products = products as? [BBInvestmentAccount] else { return recipients }
        for product in products {
            let recipient = RecipientModel()
            recipient.objectId = product.identifier
            recipient.accountName = product.productName
            recipient.typeIdentifier = typeIdentifier
            recipient.objectType = product.className
            recipient.rawString = product.jsonString()
            recipient.balance = product.currentInvestmentValue?.stringValue
            recipient.currency = product.currency
            recipient.accountNumber = IBANFormatter.formatIBAN(product.iban)
            recipients.append(recipient)
        }
        return recipients
    }
}

final class LoanConverter: NSObject, BBProductConverter {
    func convert(_ products: [BBBaseProduct], withTypeIdentifier typeIdentifier: String?) -> [RecipientModel] {
        var recipients: [RecipientModel] = []
        guard let products = products as? [BBLoan] else { return recipients }
        for product in products {
            let recipient = RecipientModel()
            recipient.objectId = product.identifier
            recipient.accountName = product.productName
            recipient.typeIdentifier = typeIdentifier
            recipient.objectType = product.className
            recipient.rawString = product.jsonString()
            recipient.balance = product.bookedBalance?.stringValue
            recipient.currency = product.currency
            recipient.accountNumber = IBANFormatter.formatIBAN(product.iban)
            recipients.append(recipient)
        }
        return recipients
    }
}
