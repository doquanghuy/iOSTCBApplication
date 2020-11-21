//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit

public extension CAKeyframeAnimation {
    static func horizontalShake(in frame: CGRect, numberOfShakes: Int, vigour: CGFloat, duration: CFTimeInterval) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.duration = duration
        animation.isAdditive = true

        var values = [CGFloat]()
        var keyTimes = [CGFloat]()
        values.append(0.0)
        keyTimes.append(0.0)
        for index in 1 ..< numberOfShakes {
            values.append(vigour * ((index % 2 == 0) ? 1 : -1))
            keyTimes.append(CGFloat(index) * (1.0 / CGFloat(numberOfShakes)))
        }
        values.append(0.0)
        keyTimes.append(1.0)

        animation.values = values
        animation.keyTimes = keyTimes as [NSNumber]

        return animation
    }
}
