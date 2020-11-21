//
//  UIColor+Extensions.swift
//  TCBPay
//
//  Created by Duong Dinh on 7/29/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import UIKit

extension UIColor {
    static let appColor = UIColor.white.withAlphaComponent(0.9)
    static let appRedColor = UIColor(red: 237/255, green: 28/255, blue: 36/255, alpha: 1.0)
    static let appYellowColor = UIColor(red: 254/255, green: 192/255, blue: 19/255, alpha: 1.0)
    static let grayBackground = UIColor(hexString: "f5f5f5")
    static let segmentBackground = UIColor(hexString: "eeeeee")
    static let line = UIColor(hexString: "e8e8e8")
    static let blackButtonBackground = UIColor(hexString: "262626")
    static let darkGreyBlue = UIColor(hexString: "334955")
    static let cloudyBlue = UIColor(hexString: "cbd9e1")
}

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
