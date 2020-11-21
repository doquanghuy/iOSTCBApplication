//
//  Array+Extensions.swift
//  CustomKeyboard
//
//  Created by Pham Thanh Hoa on 9/19/20.
//  Copyright © 2020 Pham Thanh Hoa. All rights reserved.
//

import Foundation

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
