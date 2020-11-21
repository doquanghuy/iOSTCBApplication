//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import ProductsClient

/// Use this formatter to to format account number and amount in a specific format by the given product class type.
struct ProductsFormatter {
    let amountUtils = AmountUtils()
    static let convertersMapping: [String: BBProductConverter.Type] = ["BBCurrentAccount": CurrentAccountConverter.self,
                                                                       "BBSavingsAccount": SavingsAccountConverter.self,
                                                                       "BBDebitCard": DebitCardConverter.self,
                                                                       "BBCreditCard": CreditCardConverter.self,
                                                                       "BBTermDeposit": TermDepositConverter.self,
                                                                       "BBInvestmentAccount": InvestmentAccountConverter.self,
                                                                       "BBLoan": LoanConverter.self]

    func recipientModel(for product: BBBaseProduct) -> RecipientModel? {
        let factory = BBProductConverterFactory(mapping: ProductsFormatter.convertersMapping)
        let converter = factory.converter(for: product.classForCoder)
        return converter.convert([product], withTypeIdentifier: "0").first
    }

    /**
     Formats the amount string depending on product type. Will superscript the fraction.
     @param product The product to format the amount for.
     @param font The font to be used.
     @param color The color to be used.
     @return A string with a superscripted fraction.
     */
    func amount(for product: BBBaseProduct, usingFont font: UIFont, color: UIColor) -> NSAttributedString {
        if let displayAmount = amount(for: product) {
            return displayAmount.bb.superscript(using: font, with: color)
        }
        return NSAttributedString(string: "")
    }

    func amount(for product: BBBaseProduct) -> String? {
        guard let recipientModel = recipientModel(for: product),
            let currency = recipientModel.currency,
            let balance = recipientModel.balance else { return "" }
        let amount = NSDecimalNumber(string: balance)
        return amountUtils.formatAmount(amount, currency)
    }

    func productNumber(for product: BBBaseProduct) -> String? {
        guard let recipientModel = recipientModel(for: product) else { return "" }
        return recipientModel.accountNumber
    }

    func total(for summary: BBProductSummary) -> String? {
        guard
            let total = summary.aggregatedBalance,
            let aggregatedBalance = total.value,
            let currency = total.currency
            else { return summary.aggregatedBalance?.value?.stringValue }

        return amountUtils.formatAmount(aggregatedBalance, currency)
    }

    func total(for kind: BBProductKind) -> String? {
        guard
            let aggregatedBalance = kind.aggregatedBalance?.value,
            let currency = kind.aggregatedBalance?.currency
            else { return kind.aggregatedBalance?.value?.stringValue }

        return amountUtils.formatAmount(aggregatedBalance, currency)
    }
}
