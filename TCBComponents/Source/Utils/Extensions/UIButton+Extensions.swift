//
// Copyright © 2020 Backbase R&D B.V. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setTitleColor(_ color: UIColor?, for states: [UIControl.State] = [.normal, .highlighted, .disabled]) {
        states.forEach {
            self.setTitleColor(color, for: $0)
        }
    }

    func alignImageAndTitleVertically(padding: CGFloat = 0.0) {
        let imageSize = self.imageView?.frame.size ?? .zero
        let titleSize = self.titleLabel?.frame.size ?? .zero
        let totalHeight = imageSize.height + titleSize.height + padding

        self.imageEdgeInsets = UIEdgeInsets(top: -(totalHeight - imageSize.height),
                                            left: 0,
                                            bottom: 0,
                                            right: -titleSize.width)

        self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                            left: -imageSize.width,
                                            bottom: -(totalHeight - titleSize.height),
                                            right: 0)
    }
}
