//
//  TCBMenuItemStyle.swift
//  FastMobile
//
//  Created by vuong on 10/22/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit

public protocol TCBMenuItemStyle {
    var titleColor: UIColor { get }
    var titleFont: UIFont { get }
    var subtitleColor: UIColor { get }
    var subtitleFont: UIFont { get }
    var separatorColor: UIColor { get }
    var separatorHeight: CGFloat { get }
    var iconTintColor: UIColor { get }
    var iconBackgroundColor: UIColor { get }
}

public struct TCBDefaultMenuItemStyle: TCBMenuItemStyle {
    public var titleColor: UIColor = DefaultDesign.colors.almostBlack
    public var titleFont: UIFont = DefaultDesign.fonts.body1Medium 
    public var subtitleColor: UIColor = DefaultDesign.colors.darkGrey
    public var subtitleFont: UIFont = DefaultDesign.fonts.body2
    public var iconTintColor: UIColor = DefaultDesign.colors.midGrey
    public var separatorColor: UIColor = DefaultDesign.colors.almostLightGrey
    public var separatorHeight: CGFloat = 1 / UIScreen.main.scale
    public var iconBackgroundColor: UIColor = .clear
    
    public init() {}
}
