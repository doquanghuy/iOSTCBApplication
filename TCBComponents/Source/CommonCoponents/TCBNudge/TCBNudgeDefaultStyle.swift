//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import Foundation
import UIKit

public class TCBNudgeDefaultStyle: TCBNudgeStyle {

    public var backgroundColor: UIColor { return DefaultDesign.colors.white }
    public var titleFont: UIFont { return DefaultDesign.fonts.body2Medium }
    public var messageFont: UIFont { return DefaultDesign.fonts.body2 }
    public var titleColor: UIColor { return DefaultDesign.colors.almostBlack }
    public var messageColor: UIColor { return DefaultDesign.colors.darkGrey }
    public var warningIcon: UIImage? { return UIImage(named: "ic_warning",
                                                      in: Bundle(for: TCBNudgeDefaultStyle.self),
                                                      compatibleWith: nil) }
    public var infoIcon: UIImage? { return UIImage(named: "ic_check_circle",
                                                   in: Bundle(for: TCBNudgeDefaultStyle.self),
                                                   compatibleWith: nil) }
    public var errorIcon: UIImage? { return UIImage(named: "ic_error",
                                                    in: Bundle(for: TCBNudgeDefaultStyle.self),
                                                    compatibleWith: nil) }
    public var successIcon: UIImage? {
        return UIImage(named: "ic_check_circle",in: Bundle(for: TCBNudgeDefaultStyle.self),compatibleWith: nil)
    }
    
    public init() {}
}
