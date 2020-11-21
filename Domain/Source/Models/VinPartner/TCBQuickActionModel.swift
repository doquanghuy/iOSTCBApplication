//
//  QuickActionModel.swift
//  FastMobile
//
//  Created by Techcom on 9/11/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

public struct TCBQuickActionModel: Codable {
    
    public enum ActionType: Int, Codable {
        case `default`
        case transfer
        case payBill
    }
    
    public let type: ActionType
    public let title: String
    public let iconName: String
    
    public init(type: ActionType = .default, title: String, iconName: String) {
        self.type = type
        self.title = title
        self.iconName = iconName
    }
}
