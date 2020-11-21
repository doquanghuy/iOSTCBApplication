//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit

public class CheckboxView: UIView {
    private var radius: CGFloat = 0

    @objc public dynamic var emptyColor: UIColor = .clear
    @objc public dynamic var checkedColor: UIColor = .black
    public var isChecked: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }

    public override var frame: CGRect {
        didSet {
            self.radius = (self.bounds.width > 10) ? 10 : self.bounds.width
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }

    public override func draw(_ rect: CGRect) {
        let xOffset = (rect.width - radius) / 4
        let yOffset = (rect.width - radius) / 4
        let circleRect = rect.insetBy(dx: xOffset, dy: yOffset)

        let fillColor = isChecked ? checkedColor : emptyColor
        fillColor.setFill()

        let strokeColor = checkedColor
        strokeColor.setStroke()

        let bezierPath = UIBezierPath(ovalIn: circleRect)
        bezierPath.lineWidth = 2.0

        bezierPath.fill()
        bezierPath.stroke()
    }
}
