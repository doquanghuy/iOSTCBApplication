//
// Copyright © 2020 Backbase R&D B.V. All rights reserved.
//

import Foundation
import UIKit

public class TCBNudgeNotificationDefaultStyle: TCBNudgeNotificationStyle {
    public var alertLevelColor: UIColor { return DefaultDesign.colors.supportDanger}
    public var infoLevelColor: UIColor { return DefaultDesign.colors.supportInfo }
    public var successLevelColor: UIColor { return DefaultDesign.colors.supportSuccess }
    public var warningLevelColor: UIColor { return DefaultDesign.colors.supportWarning }
    
    public init() {}
}
