//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit

@objc public protocol TCBNudgeStyle: AnyObject {
    var backgroundColor: UIColor { get }
    var titleFont: UIFont { get }
    var messageFont: UIFont { get }
    var titleColor: UIColor { get }
    var messageColor: UIColor { get }
    var warningIcon: UIImage? { get }
    var errorIcon: UIImage? { get }
    var infoIcon: UIImage? { get }
    var successIcon: UIImage? { get }
}
