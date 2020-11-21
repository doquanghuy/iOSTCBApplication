//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit

public protocol AppFonts {
    func defaultFont(ofSize size: CGFloat) -> UIFont
    func defaultFont(ofSize size: CGFloat, weight: UIFont.Weight?) -> UIFont
    func defaultMediumFont(ofSize size: CGFloat) -> UIFont
    func amountFont(ofSize size: CGFloat, weight: UIFont.Weight?) -> UIFont

    var fontScale: CGFloat { get }
    var defaultFont: UIFont { get }
    var h1: UIFont { get }
    var h2: UIFont { get }
    var h3: UIFont { get }
    var title1: UIFont { get }
    var body1Medium: UIFont { get }
    var body1Bold: UIFont { get }
    var body2Bold: UIFont { get }
    var body2Medium: UIFont { get }
    var captionMedium: UIFont { get }
    var button: UIFont { get }
    var buttonSmall: UIFont { get }
    var tabbarItem: UIFont { get }
    var body1: UIFont { get }
    var body2: UIFont { get }
    var body3: UIFont { get }
    var caption: UIFont { get }
    var caption2: UIFont { get }
    var amountDefault: UIFont { get }
    var amountDefaultRegular: UIFont { get }
    var amountDefaultMedium: UIFont { get }
    var amountDefaultDecimals: UIFont { get }
    var amountLarge: UIFont { get }
    var amountExtraLarge: UIFont { get }
    var amountLargeDecimals: UIFont { get }
    var navigationBarTitle1: UIFont { get }
    var navigationBarTitle2: UIFont { get }
    var largeTitle: UIFont { get }
    var secondaryLargeTitle: UIFont { get }
}
