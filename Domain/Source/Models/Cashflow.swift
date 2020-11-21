//
//  Cashflow.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/11/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

public struct Cashflow: Codable {
    public var notice: String?
    public var barChart: [BarChart]?

    public init(notice: String? = nil, barChart: [BarChart]? = nil) {
        self.notice = notice
        self.barChart = barChart
    }
}
