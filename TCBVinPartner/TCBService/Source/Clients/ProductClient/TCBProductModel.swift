//
//  TCBProductModel.swift
//  BackbasePlatform
//
//  Created by Son le on 10/9/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import Backbase
import ProductsClient

public struct TCBProductModel {
    public let name: String
    public let aggregatedBalance: String
    public let accounts: [AccountSummaryData]
    public init(name: String,
                aggregatedBalance: String,
                accounts: [AccountSummaryData]) {
        self.name = name
        self.aggregatedBalance = aggregatedBalance
        self.accounts = accounts
    }
}

public struct AccountSummaryData {
    public let name: String
    public let category: String
    public let amount: NSAttributedString
    public let accessory: AccountSummaryAccessory?

    public init(name: String, category: String, amount: NSAttributedString, accessory: AccountSummaryAccessory?) {
        self.name = name
        self.category = category
        self.amount = amount
        self.accessory = accessory
    }
}

public struct AccountSummaryIcon {
    public let bundleIcon: String?
    public let serverIcon: String?

    public func bundleIconImage() -> UIImage? {
        if let bundleIcon = bundleIcon {
            return UIImage(named: bundleIcon)?.withRenderingMode(.alwaysTemplate)
        }
        return nil
    }
}

public struct AccountSummaryAccessory {
    public let categoryColor: UIColor?
    public let image: AccountSummaryIcon?

    init(image: AccountSummaryIcon?, categoryColor: UIColor?) {
        self.categoryColor = categoryColor
        self.image = image
    }
}
