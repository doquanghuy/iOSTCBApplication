//
// Copyright © 2020 Backbase R&D B.V. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self
        constraint.priority = priority
        return constraint
    }
}
