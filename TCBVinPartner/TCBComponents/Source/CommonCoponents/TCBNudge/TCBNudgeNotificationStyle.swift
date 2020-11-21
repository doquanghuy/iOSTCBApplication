//
// Copyright © 2020 Backbase R&D B.V. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol TCBNudgeNotificationStyle: AnyObject {
    var alertLevelColor: UIColor { get }
    var infoLevelColor: UIColor { get }
    var successLevelColor: UIColor { get }
    var warningLevelColor: UIColor { get }
}
