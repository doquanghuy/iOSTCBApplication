//
// Copyright © 2020 Backbase R&D B.V. All rights reserved.
//

import Foundation
import UIKit

enum DateFormat: String {
    case isoOffsetDateFormatWithMilliseconds = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
    case fullDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
    case mediumDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    case shortDateFormat = "yyyy-MM-dd"
    case usDateFormat = "MM/dd/yyyy"
    case descriptiveDateFormat = "MMM d, yyyy"
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var absoluteLocalized: String? {
        guard localized != self else { return nil } // value is the same as key -> key is not localized
        return localized
    }

    var isDigits: Bool {
        if self.isEmpty { return false }
        let invalidCharset = NSCharacterSet.decimalDigits.inverted
        return self.rangeOfCharacter(from: invalidCharset) == nil
    }

    var digits: String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }

    var nsNumber: NSNumber? {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = Locale.current.groupingSeparator
        formatter.decimalSeparator = Locale.current.decimalSeparator
        let number = formatter.number(from: self)
        if number != nil { return number }

        formatter.groupingSeparator = Locale.current.decimalSeparator
        formatter.decimalSeparator = Locale.current.groupingSeparator
        return formatter.number(from: self)
    }

    func decimalNumber(exponents: Int16 = -2) -> NSDecimalNumber {
        let isNegative = !self.filter { $0 == "-" }.isEmpty
        guard let uInt64 = nsNumber?.uint64Value else { return NSDecimalNumber(string: "0") }
        return NSDecimalNumber(mantissa: uInt64, exponent: exponents, isNegative: isNegative)
    }

    var serializedObject: NSDictionary {
        let dict = NSDictionary()
        guard let data = self.data(using: .utf8) else { return dict }
        do {
            let payload = try JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0)) as? NSDictionary
            return payload ?? dict
        } catch {
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
    func date(withFormat format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = .current
        formatter.timeZone = .current
        return formatter.date(from: self)
    }

    var isoDate: Date? {
        return date(withFormat: DateFormat.isoOffsetDateFormatWithMilliseconds.rawValue)
    }

    var isoDateWithShortFormat: Date? {
        return date(withFormat: DateFormat.shortDateFormat.rawValue)
    }

    func superscript(using font: UIFont = DefaultDesign.fonts.amountLarge,
                     with color: UIColor) -> NSAttributedString {
        var amountValue = NSAttributedString(string: self)

        do {
            let superscriptRange = try rangeForSuperscriptedString()
            amountValue = formattedDetailsString(with: font, color: color, superscriptRange: superscriptRange)
        } catch {
        }
        return amountValue
    }

    func attributted(using font: UIFont? = nil, with color: UIColor) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [.foregroundColor: color]
        if let font = font {
            attributes[.font] = font
        }
        return NSMutableAttributedString(string: self, attributes: attributes)
    }

    func formattedDetailsString(with font: UIFont, color: UIColor, superscriptRange: NSRange) -> NSAttributedString {
        let superscriptFontSize = (font.pointSize / 4) * 2.5
        let baselineOffset = (font.pointSize - superscriptFontSize) - 1.5

        let attr: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]

        let attributedText = NSMutableAttributedString(string: self, attributes: attr)

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
            !self.isEmpty,
            let decimalSeparator = locale.decimalSeparator,
            let range = self.range(of: decimalSeparator, options: .backwards)
            else {
                return NSRange(location: 0, length: 0)
        }

        let separatorIndex = NSRange(range, in: self).location + 1
        let substring = String(self[self.index(self.startIndex, offsetBy: separatorIndex)...])
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
        var hexString = self

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

        guard toLength > self.count else { return self }

        let padding = String(repeating: withPad, count: toLength - self.count)
        return padding + self
    }
}

extension Double {
    var formattedNumber: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let formattedNumber = numberFormatter.string(from:
            NSNumber(value: self)) else { return nil }
        
        return formattedNumber
    }
    
    var originString: String {
        return String(format: "%1.0f", self)
    }
}

extension String {
    var formattedNumber: String? {
        guard !self.isEmpty else { return nil }
        return doubleValue.formattedNumber
    }
    
    var doubleValue: Double {
        let text = replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: ".", with: "")
        
        return Double(text) ?? 0
    }
}
