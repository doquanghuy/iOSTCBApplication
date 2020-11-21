//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit

public protocol AppColors {
    // Action
    var primary: UIColor { get }
    var secondary: UIColor { get }

    // Support
    var supportWarning: UIColor { get }
    var supportDanger: UIColor { get }
    var supportInfo: UIColor { get }
    var supportSuccess: UIColor { get }

    // Neutral - Light
    var white: UIColor { get }
    var almostWhite: UIColor { get }
    var slightlyLightGrey: UIColor { get }
    var almostGrey: UIColor { get }

    // Neutral - Mid
    var almostLightGrey: UIColor { get }
    var lightGrey: UIColor { get }
    var grey: UIColor { get }
    var midGrey: UIColor { get }

    // Neutral - Dark
    var darkGrey: UIColor { get }
    var almostBlack: UIColor { get }

    // Actions - Primary
    var primaryLight: UIColor { get }
    var primaryLighter: UIColor { get }

    var primaryDark: UIColor { get }
    var primaryDarker: UIColor { get }
    var primaryDarkest: UIColor { get }

    // Actions - Secondary
    var secondaryDark: UIColor { get }
    var secondaryDarker: UIColor { get }

    // Support - Danger
    var supportDangerDark: UIColor { get }
    var supportDangerDarker: UIColor { get }

    // Support - Success
    var supportSuccessDark: UIColor { get }
    var supportSuccessDarker: UIColor { get }

    // Secondary
    var secondaryLime: UIColor { get }
    var secondaryTeal: UIColor { get }
    var secondaryLightBlue: UIColor { get }
    var secondaryLightBlueDarker: UIColor { get }
    var secondaryIndigo: UIColor { get }
    var secondaryPurple: UIColor { get }
    var secondaryPink: UIColor { get }
    var secondaryYellow: UIColor { get }
    var secondaryTango: UIColor { get }
    var secondaryOrange: UIColor { get }
    var secondaryGrey: UIColor { get }
}
