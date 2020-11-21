//
//  File.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/19/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit

public extension CALayer {
    
    @discardableResult
    func addShadow() -> CALayer {
        shadowOffset = .zero
        shadowOpacity = 0.1
        shadowRadius = 8
        shadowColor = UIColor.black.cgColor
        masksToBounds = false
        
        return self
    }
}
