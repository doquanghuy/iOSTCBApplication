//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import Backbase
import CommonUtils
import Foundation
import ProductsClient

extension BackbaseWrapper where Base == String {
    var localized: String {
        return NSLocalizedString(base, comment: "")
    }

    var absoluteLocalized: String? {
        guard localized != base else { return nil } // value is the same as key -> key is not localized
        return localized
    }

    var isDigits: Bool {
        if base.isEmpty { return false }
        let invalidCharset = NSCharacterSet.decimalDigits.inverted
        return base.rangeOfCharacter(from: invalidCharset) == nil
    }

    var digits: String {
        return base.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }

    var nsNumber: NSNumber? {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = Locale.current.groupingSeparator
        formatter.decimalSeparator = Locale.current.decimalSeparator
        let number = formatter.number(from: base)
        if number != nil { return number }

        formatter.groupingSeparator = Locale.current.decimalSeparator
        formatter.decimalSeparator = Locale.current.groupingSeparator
        return formatter.number(from: base)
    }

    func decimalNumber(exponents: Int16 = -2) -> NSDecimalNumber {
        let isNegative = !base.filter { $0 == "-" }.isEmpty
        guard let uInt64 = nsNumber?.uint64Value else { return NSDecimalNumber(string: "0") }
        return NSDecimalNumber(mantissa: uInt64, exponent: exponents, isNegative: isNegative)
    }

    var serializedObject: NSDictionary {
        let dict = NSDictionary()
        guard let data = base.data(using: .utf8) else { return dict }
        do {
            let payload = try JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0)) as? NSDictionary
            return payload ?? dict
        } catch {
            Backbase.logError(self, message: error.localizedDescription)
        }
        return dict
    }

    /// Date object from string of date format.
    ///
    ///        "2017-01-15".date(withFormat: "yyyy-MM-dd") -> Date set to Jan 15, 2017
    ///        "not date string".date(withFormat: "yyyy-MM-dd") -> nil
    ///
    /// - Parameter format: date format.
    /// - Returns: Date object from string (if applicable).
    func date(withFormat format: Base) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = .current
        formatter.timeZone = .current
        return formatter.date(from: base)
    }

    var isoDate: Date? {
        return date(withFormat: BBDateFormat.bbISOOffsetDateFormatWithMilliseconds.rawValue)
    }

    var isoDateWithShortFormat: Date? {
        return date(withFormat: BBDateFormat.bbShortDateFormat.rawValue)
    }
    
    var utcShortDate: Date? {
        return BBDateManager.shared().formattedDate(from: base, usingFormat: .bbShortDateFormat)
    }

    func superscript(using font: UIFont = UIFont.systemFont(ofSize: 20.0, weight: .semibold), with color: UIColor) -> NSAttributedString {
        var amountValue = NSAttributedString(string: base)

        do {
            let superscriptRange = try rangeForSuperscriptedString()
            amountValue = formattedDetailsString(with: font, color: color, superscriptRange: superscriptRange)
        } catch {
            Backbase.logError(self, message: error.localizedDescription)
        }
        return amountValue
    }

    func attributted(using font: UIFont? = nil, with color: UIColor) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [.foregroundColor: color]
        if let font = font {
            attributes[.font] = font
        }
        return NSMutableAttributedString(string: base, attributes: attributes)
    }

    func formattedDetailsString(with font: UIFont, color: UIColor, superscriptRange: NSRange) -> NSAttributedString {
        let superscriptFontSize = (font.pointSize / 4) * 2.5
        let baselineOffset = (font.pointSize - superscriptFontSize) - 1.5

        let attr: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]

        let attributedText = NSMutableAttributedString(string: base, attributes: attr)

        if superscriptRange.length <= 0 {
            return attributedText
        }

        let superscriptFont = font.withSize(superscriptFontSize)
        let superscriptAttr: [NSAttributedString.Key: Any] = [.font: superscriptFont,
                                                              .baselineOffset: baselineOffset,
                                                              .foregroundColor: color]
        attributedText.setAttributes(superscriptAttr, range: superscriptRange)
        return attributedText
    }

    func rangeForSuperscriptedString(for locale: Locale = Locale.current) throws -> NSRange {
        guard
            !base.isEmpty,
            let decimalSeparator = locale.decimalSeparator,
            let range = base.range(of: decimalSeparator, options: .backwards)
            else {
                return NSRange(location: 0, length: 0)
        }

        let separatorIndex = NSRange(range, in: base).location + 1
        let substring = String(base[base.index(base.startIndex, offsetBy: separatorIndex)...])
        let regex = try NSRegularExpression(pattern: "([0-9]*)", options: .init(rawValue: 0))
        let match = regex.firstMatch(in: substring, options: .init(rawValue: 0), range: NSRange(location: 0, length: substring.count))

        return NSRange(location: separatorIndex, length: match?.range(at: 1).length ?? 0)
    }

    static func currencySymbol(forCurrencyCode code: String) -> String? {
        let localeIdentifier = Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: code])
        let locale = Locale(identifier: localeIdentifier)
        return locale.currencySymbol
    }

    static func simplifiedCurrencySymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: .currencySymbol, value: code)
    }

    func removeHexPrefixes() -> String {
        var hexString = base

        if hexString.hasPrefix("#") { // Remove the '#' prefix if added.
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            hexString = String(hexString[start...])
        }

        if hexString.lowercased().hasPrefix("0x") { // Remove the '0x' prefix if added.
            let start = hexString.index(hexString.startIndex, offsetBy: 2)
            hexString = String(hexString[start...])
        }

        return hexString
    }

    func leftPadding(toLength: Int, withPad: String = " ") -> String {

        guard toLength > base.count else { return base }

        let padding = String(repeating: withPad, count: toLength - base.count)
        return padding + base
    }
}

extension String {
    func formatCardNumber() -> String {
        return separate(every: 4, with: " ")
    }

    func separate(every stride: Int = 4, with separator: String = " ") -> String {
        return split(by: stride).joined(separator: separator)
    }

    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results: [Substring] = []

        while startIndex < endIndex {
            let endIndex = index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex ..< endIndex])
            startIndex = endIndex
        }

        return results.map(String.init)
    }
}

extension BBBaseProduct {
    var isVisible: Bool {
        return userPreferences?.visible?.boolValue ?? true
    }

    var productName: String {
        return userPreferences?.alias ?? name ?? ""
    }
}
