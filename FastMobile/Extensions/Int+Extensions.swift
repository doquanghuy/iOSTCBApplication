//
//  Int.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/14/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

extension Int {
    
    func formatCurrency() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        //numberFormatter.locale = Locale(identifier: "vi_VN")
        numberFormatter.usesGroupingSeparator = true
        
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    public var asWord: String {
        let numberValue = NSNumber(value: self)
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter.string(from: numberValue)!
    }
    
    func toTimeString() -> String {
        let uSeconds = abs(self)
        if uSeconds / 3600 > 0 {
            let hour = uSeconds / 3600
            return "\(hour) hours ago"
        } else if uSeconds / 60 > 0 {
            let minute = uSeconds / 60
            return "\(minute) minutes ago"
        } else {
            return "\(uSeconds) seconds ago"
        }
    }
}
