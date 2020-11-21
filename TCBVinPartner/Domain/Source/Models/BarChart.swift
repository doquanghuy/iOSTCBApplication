//
//  BarChart.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/11/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit

public struct BarChart: Codable {
    public var height: CGFloat = 0
    public var color: String?
    //shown on top of the bar
    public let textValue: String?
    //shown at the bottom of the bar
    public let title: String?

    public init(height: CGFloat = 0, color: String? = nil, textValue: String?, title: String?) {
        self.height = height
        self.color = color
        self.textValue = textValue
        self.title = title
    }
}
