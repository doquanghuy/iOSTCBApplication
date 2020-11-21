//
//  UIFont+Extensions.swift
//  TCBPay
//
//  Created by Dinh Duong on 9/12/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import UIKit

extension UIFont {
    
    static let buttonTextFont = UIFont(name: "HelveticaNeue-Medium", size: 16)
    static let headerFont = UIFont(name: "HelveticaNeue-Bold", size: 30)
    static let messageFont = UIFont(name: "HelveticaNeue-Regular", size: 19)
}

extension UIFont {
    static func mediumFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size) ?? .boldSystemFont(ofSize: size)
    }
    
    static func boldFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size) ?? .boldSystemFont(ofSize: size)
    }
    
    static func regularFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Regular", size: size) ?? .systemFont(ofSize: size)
    }
}
