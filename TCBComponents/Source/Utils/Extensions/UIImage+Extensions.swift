//
// Copyright © 2020 Backbase R&D B.V. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func tint(with color: UIColor) -> UIImage {
        var image = self.withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.set()

        image.draw(in: CGRect(origin: .zero, size: image.size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func resize(toSize size: CGSize, scale: CGFloat) -> UIImage? {
        let imgRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: imgRect)
        let resizedImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImg
    }
}
