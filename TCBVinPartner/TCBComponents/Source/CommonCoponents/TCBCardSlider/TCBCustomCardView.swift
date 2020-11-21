//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit

/// This is abstract class for CardSlider's item
/// It apply basic shadows and effects
open class TCBCardBaseView: UIView {
    public var accentColor: UIColor {
        didSet {
            accentColor = accentColor.withAlphaComponent(0.8)
        }
    }

    public var fillColor: UIColor {
        didSet {
            setNeedsDisplay()
        }
    }

    open var cornerRadius: CGFloat { return 4 }

    required public init?(coder aDecoder: NSCoder) {
        accentColor = DefaultDesign.colors.primary
        fillColor = DefaultDesign.colors.almostWhite
        super.init(coder: aDecoder)
        applyShadow()
    }

    public init(accentColor: UIColor, fillColor: UIColor, frame: CGRect) {
        self.accentColor = accentColor
        self.fillColor = fillColor
        super.init(frame: frame)
        applyShadow()
    }

    open override func draw(_ rect: CGRect) {
        fillColor.set()

        let corners = [UIRectCorner.topLeft, UIRectCorner.topRight, UIRectCorner.bottomLeft, UIRectCorner.bottomRight] as UIRectCorner
        let cornerRadius = CGSize(width: self.cornerRadius, height: self.cornerRadius)
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: cornerRadius)
        path.fill()

        let corners2 = [UIRectCorner.topLeft, UIRectCorner.bottomLeft] as UIRectCorner
        let fillRect = CGRect(x: 0, y: 0, width: 8, height: rect.size.height)
        let path2 = UIBezierPath(roundedRect: fillRect, byRoundingCorners: corners2, cornerRadii: cornerRadius)
        accentColor.setFill()
        path2.fill()
    }

    open func setup(context: TCBCardSliderItem) {
        preconditionFailure("Method not implemented")
    }

    open func applyShadow() {
//        applyShadow(radius: 2, opacity: 0.1, offset: CGSize(width: 0, height: 2))
    }
}
