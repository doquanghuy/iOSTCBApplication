//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import Backbase
import ProductsClient

struct ProductKindUtils {
    func localizedProductKindsName(for kClass: AnyClass) -> String {
        switch kClass {
        case is BBCurrentAccounts.Type, is BBCurrentAccount.Type:
            return "product_kind_current_accounts".bb.localized
        case is BBSavingsAccounts.Type, is BBSavingsAccount.Type:
            return "product_kind_savings_accounts".bb.localized
        case is BBTermDeposits.Type, is BBTermDeposit.Type:
            return "product_kind_term_deposits".bb.localized
        case is BBCreditCards.Type, is BBCreditCard.Type:
            return "product_kind_credit_cards".bb.localized
        case is BBDebitCards.Type, is BBDebitCard.Type:
            return "product_kind_debit_cards".bb.localized
        case is BBLoans.Type, is BBLoan.Type:
            return "product_kind_loans".bb.localized
        case is BBInvestmentAccounts.Type, is BBInvestmentAccount.Type:
            return "product_kind_investment_accounts".bb.localized
        default:
            return ""
        }
    }
}
