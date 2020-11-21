//
//  RecentActivity.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/11/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

public struct RecentActivity: Codable {
    public var amount: Int?
    public var currencyCode: String?
    public var category: String?
    public var title: String?
    public var logo: String?
    public var avatar: String?

    public init(amount: Int? = nil, currencyCode: String? = nil, category: String? = nil, title: String? = nil, logo: String? = nil, avatar: String? = nil) {
        self.amount = amount
        self.currencyCode = currencyCode
        self.category = category
        self.title = title
        self.logo = logo
        self.avatar = avatar
    }
}
