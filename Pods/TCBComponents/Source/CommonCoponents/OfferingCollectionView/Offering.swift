//
//  Offering.swift
//  TCBComponents
//
//  Created by Son le on 10/15/20.
//

import UIKit

public struct OfferingItem {
    var backgroundImage: UIImage?
    var logo: UIImage?
    var title: String?
    var subtitle: String?

    public init(backgroundImage: UIImage? = nil,
                logo: UIImage? = nil,
                title: String? = nil,
                subtitle: String? = nil) {
        self.backgroundImage = backgroundImage
        self.logo = logo
        self.title = title
        self.subtitle = subtitle
    }
}
