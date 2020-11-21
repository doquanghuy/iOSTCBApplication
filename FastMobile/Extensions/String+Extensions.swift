//
//  String+Extensions.swift
//  CustomKeyboard
//
//  Created by Pham Thanh Hoa on 9/19/20.
//  Copyright © 2020 Pham Thanh Hoa. All rights reserved.
//

import Foundation
import UIKit

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
    
    func height(with width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)

        return ceil(boundingBox.height)
    }

    func width(with height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)

        return ceil(boundingBox.width)
    }
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

extension String {
    
    func addAttributes( _ attrs: [String: [NSAttributedString.Key: Any]]) -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: self)
        
        attrs.forEach { text, attr in
            let range = (self as NSString).range(of: text)
            attrString.addAttributes(attr, range: range)
        }
        
        return attrString
    }
}
