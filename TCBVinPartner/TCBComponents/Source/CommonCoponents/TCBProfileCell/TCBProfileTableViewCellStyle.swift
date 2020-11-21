//
//  TCBMenuItemStyle.swift
//  TCBComponents
//
//  Created by vuong on 11/1/20.
//

import UIKit

public protocol TCBProfileTableViewCellStyle {
    var titleColor: UIColor { get }
    var titleFont: UIFont { get }
    var valueColor: UIColor { get }
    var valueFont: UIFont { get }
}

public struct TCBDefaultTCBProfileTableViewCellStyle: TCBProfileTableViewCellStyle {
    public var titleColor: UIColor = .black
     
    public var titleFont: UIFont =  UIFont.boldSystemFont(ofSize: 17.0)
    
    public var valueColor: UIColor = .black
    
    public var valueFont: UIFont = UIFont.systemFont(ofSize: 15.0)

    public init() {}
}
