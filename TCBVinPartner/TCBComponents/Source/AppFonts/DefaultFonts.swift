//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit

public struct DefaultFonts: AppFonts {
    public init() {}

    public func defaultFont(ofSize size: CGFloat) -> UIFont {
        return defaultFont(ofSize: size, weight: nil)
    }

    public func defaultFont(ofSize size: CGFloat, weight: UIFont.Weight? = nil) -> UIFont {
        if let weight = weight {
            return UIFont.systemFont(ofSize: size, weight: weight)
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }

    public func defaultMediumFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }

    public func amountFont(ofSize size: CGFloat, weight: UIFont.Weight? = nil) -> UIFont {
        let newDescriptor = defaultFont(ofSize: size, weight: weight)
            .fontDescriptor
            .addingAttributes([UIFontDescriptor.AttributeName.featureSettings: [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
                                                                                 UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]])
        return UIFont(descriptor: newDescriptor, size: size)
    }

    /**
     * Returns a factor representing the scale to resize some fonts for accesibility.
     */
    public var fontScale: CGFloat {
        let scale = UIFont.preferredFont(forTextStyle: .body).pointSize / 17.0
        return scale > 1 ? scale : 1.0 // Only scale it up, never down.
    }

    // MARK: - Fonts

    ///
    public var defaultFont: UIFont { return defaultFont(ofSize: UIFont.systemFontSize) }

    /// 32 - Semibold
    public var h1: UIFont { return defaultFont(ofSize: 32 * fontScale, weight: .semibold) }

    /// 24 - Medium
    public var h2: UIFont { return defaultMediumFont(ofSize: 24) }

    /// 17 - Medium
    public var h3: UIFont { return defaultMediumFont(ofSize: 17 * fontScale) }

    ///
    public var title1: UIFont { return UIFont.preferredFont(forTextStyle: .title1) }

    /// 16 - Medium
    public var body1Medium: UIFont { return defaultMediumFont(ofSize: 16 * fontScale) }

    /// 16 - Semibold
    public var body1Bold: UIFont { return defaultFont(ofSize: 16 * fontScale, weight: .semibold) }

    /// 17 - Semibold
    public var body2Bold: UIFont { return defaultFont(ofSize: 17 * fontScale, weight: .semibold) }

    /// 14 - Medium
    public var body2Medium: UIFont { return defaultMediumFont(ofSize: 14 * fontScale) }

    /// 12 - Medium
    public var captionMedium: UIFont { return defaultMediumFont(ofSize: 12 * fontScale) }

    /// 16 - Medium
    public var button: UIFont { return defaultMediumFont(ofSize: 16 * fontScale) }

    /// 14 - Medium
    public var buttonSmall: UIFont { return defaultMediumFont(ofSize: 14 * fontScale) }

    /// 14 - Medium
    public var tabbarItem: UIFont { return defaultMediumFont(ofSize: 10) }

    /// 16 - Regular
    public var body1: UIFont { return defaultFont(ofSize: 16 * fontScale) }

    /// 14 - Regular
    public var body2: UIFont { return defaultFont(ofSize: 14 * fontScale) }

    /// 14 - Semibold
    public var body3: UIFont { return amountFont(ofSize: 14, weight: .semibold) }

    /// 12 - Regular
    public var caption: UIFont { return defaultFont(ofSize: 12 * fontScale) }

    /// 16 - Regular
    public var caption2: UIFont { return UIFont.preferredFont(forTextStyle: .caption2) }

    /// 18 - Semibold - monospace
    public var amountDefault: UIFont { return amountFont(ofSize: 18 * fontScale, weight: .semibold) }

    /// 18 - Regular - monospace
    public var amountDefaultRegular: UIFont { return amountFont(ofSize: 18 * fontScale, weight: .regular) }

    /// 18 - Regular - monospace
    public var amountDefaultMedium: UIFont { return amountFont(ofSize: 18 * fontScale, weight: .medium) }

    /// 12 - Regular - monospace
    public var amountDefaultDecimals: UIFont { return amountFont(ofSize: 12 * fontScale) }

    /// 20 - Semibold - monospace
    public var amountLarge: UIFont { return amountFont(ofSize: 20 * fontScale, weight: .semibold) }

    /// 24 - Semibold - monospace
    public var amountExtraLarge: UIFont { return amountFont(ofSize: 24 * fontScale, weight: .semibold) }

    /// 14 - Regular - monospace
    public var amountLargeDecimals: UIFont { return amountFont(ofSize: 14 * fontScale) }

    /// 16 - Semibold - monospace
    public var navigationBarTitle1: UIFont { return amountFont(ofSize: 16, weight: .semibold) }

    /// 14 - Regular - monospace
    public var navigationBarTitle2: UIFont { return amountFont(ofSize: 14, weight: .regular) }

    /// 14 - Regular
    public var largeTitle: UIFont {
        return secondaryLargeTitle
    }

    /// 14 - Regular
    public var secondaryLargeTitle: UIFont {
        let size = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title2).pointSize
        return UIFont.boldSystemFont(ofSize: size)
    }
}
