//
// Copyright © 2020 Backbase R&D B.V. All rights reserved.
//

import Foundation

extension NSNumber {
    var localized: String {
        let formatter = NumberFormatter()
        return formatter.string(from: self) ?? self.stringValue
    }
    
    func formattedString(decimals: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimals
        formatter.minimumFractionDigits = decimals
        formatter.roundingMode = .up

        let decimalSeparator = formatter.locale.decimalSeparator ?? ""

        return formatter.string(from: self) ?? "0\(decimalSeparator)00"
    }
    
    static func number(with formattedString: String, decimals: Int = 2) -> NSNumber {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimals
        formatter.minimumFractionDigits = decimals
        formatter.roundingMode = .up

        let cleanString = formattedString.replacingOccurrences(of: formatter.groupingSeparator, with: "")

        return formatter.number(from: cleanString) ?? NSNumber(value: 0.0)
    }
}
