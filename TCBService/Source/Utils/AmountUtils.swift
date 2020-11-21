//
//  AmountUtils.swift
//  BackbasePlatform
//
//  Created by Son le on 10/8/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

struct AmountUtils {
    func numberFormatter(currencyCode: String) -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = currencyCode.uppercased()
        numberFormatter.paddingPosition = .afterPrefix
        numberFormatter.negativePrefix = "\(numberFormatter.negativePrefix ?? "") "
        numberFormatter.positivePrefix = "\(numberFormatter.positivePrefix ?? "") "
        return numberFormatter
    }

    func formatAmount(_ amount: NSDecimalNumber, _ currency: String) -> String? {
        return numberFormatter(currencyCode: currency).string(from: amount)
    }

    func formatNumberAmount(_ amount: NSNumber?, _ currency: String?) -> String? {
        guard let decimalAmount = amount?.decimalValue, let currency = currency else { return nil }
        let decimalNumber = NSDecimalNumber(decimal: decimalAmount)
        return numberFormatter(currencyCode: currency).string(from: decimalNumber)
    }
}
