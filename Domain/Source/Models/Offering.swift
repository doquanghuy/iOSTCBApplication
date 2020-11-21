//
//  Offering.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/10/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

public struct Offering: Codable {
    public var backgroundImage: String?
    public var logo: String?
    public var title: String?
    public var subtitle: String?

    public init(backgroundImage: String? = nil, logo: String? = nil, title: String? = nil, subtitle: String? = nil) {
        self.backgroundImage = backgroundImage
        self.logo = logo
        self.title = title
        self.subtitle = subtitle
    }
}
