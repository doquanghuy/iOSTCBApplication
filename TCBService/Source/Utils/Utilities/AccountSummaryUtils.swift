//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import ProductsClient

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

public struct AccountSummaryUtils {
    let formatter = ProductsFormatter()

    public init() {}

    public func formattedAccountSummary(for product: BBBaseProduct,
                                        preferences: [String: String]? = Backbase.currentModel()?.app().allPreferences()) -> AccountSummaryData {
        let amountValue = formatter.amount(for: product,
                                           usingFont: UIFont.systemFont(ofSize: 14),
                                           color: .black)
        let accessory = accessoryData(for: type(of: product), preferences: preferences)
        return AccountSummaryData(name: product.productName,
                                  category: formatter.productNumber(for: product) ?? "",
                                  amount: amountValue,
                                  accessory: accessory)
    }

    func accessoryData(for kClass: Any, preferences: [String: String]? = nil) -> AccountSummaryAccessory? {
        switch kClass {
        case is BBCurrentAccount.Type:
            let image = AccountSummaryIcon(bundleIcon: "ic_ac_type_current", serverIcon: preferences?[ProductIcons.currentAccountIcon])
            return AccountSummaryAccessory(image: image, categoryColor: UIColor(hexString: "00569C"))
        case is BBSavingsAccount.Type:
            let image = AccountSummaryIcon(bundleIcon: "ic_ac_type_savings", serverIcon: preferences?[ProductIcons.savingsAccountIcon])
            return AccountSummaryAccessory(image: image, categoryColor: UIColor(hexString: "74C0FC"))
        case is BBTermDeposit.Type:
            let image = AccountSummaryIcon(bundleIcon: "ic_ac_type_term", serverIcon: preferences?[ProductIcons.termDepositsIcon])
            return AccountSummaryAccessory(image: image, categoryColor: UIColor(hexString: "FD7E14"))
        case is BBCreditCard.Type:
            let image = AccountSummaryIcon(bundleIcon: "ic_ac_type_card", serverIcon: preferences?[ProductIcons.creditCardsIcon])
            return AccountSummaryAccessory(image: image, categoryColor: UIColor(hexString: "12B886"))
        case is BBDebitCard.Type:
            let image = AccountSummaryIcon(bundleIcon: "ic_ac_type_debit", serverIcon: preferences?[ProductIcons.debitCardsIcon])
            return AccountSummaryAccessory(image: image, categoryColor: UIColor(hexString: "94C052"))
        case is BBLoan.Type:
            let image = AccountSummaryIcon(bundleIcon: "ic_ac_type_loans", serverIcon: preferences?[ProductIcons.loansIcon])
            return AccountSummaryAccessory(image: image, categoryColor: UIColor(hexString: "D24887"))
        case is BBInvestmentAccount.Type:
            let image = AccountSummaryIcon(bundleIcon: "ic_ac_type_investment",
                                           serverIcon: preferences?[ProductIcons.investmentAccountsIcon])
            return AccountSummaryAccessory(image: image, categoryColor: UIColor(hexString: "883D9A"))
        default:
            return nil
        }
    }
}

private struct ProductIcons {
    static let currentAccountIcon = "currentaccount_icon"
    static let savingsAccountIcon = "savingsaccount_icon"
    static let termDepositsIcon = "termdeposits_icon"
    static let loansIcon = "loans_icon"
    static let creditCardsIcon = "creditcards_icon"
    static let debitCardsIcon = "debitcards_icon"
    static let investmentAccountsIcon = "investmentaccounts_icon"
}
