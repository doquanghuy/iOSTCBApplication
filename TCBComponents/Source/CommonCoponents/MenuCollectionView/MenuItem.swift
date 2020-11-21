//
//  MenuItem.swift
//  FastMobile
//
//  Created by Son le on 10/14/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation

public struct MenuItem {
    public let iconName: String
    public let title: String

    public init(title: String, iconName: String) {
        self.iconName = iconName
        self.title = title
    }
}
