//
//  TCBButtonBuilder.swift
//  FastMobile
//
//  Created by Thuy Truong Quang on 10/22/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit

public enum TCBButtonState {
    case inactive
    case loading
    case active
}

public protocol TCBButtonBuilder {
    func setText(text: String)
    func setTextColor(color: UIColor, forState: TCBButtonState)
    func setBackgroundColor(color: UIColor, forState: TCBButtonState)
    func setFontFamily(fontPath: UIFont)

    func setState(state: TCBButtonState)
    func setCornerRadius(radius: CGFloat)
    func getState() -> TCBButtonState
}
