//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit

public class TCBCircularProgressView: UIView {
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    // MARK: Public

    public var lineWidth: CGFloat = 1.5 {
        didSet {
            backgroundLayer.lineWidth = lineWidth
            foregroundLayer.lineWidth = lineWidth
        }
    }

    public func count(to: Double) {
        foregroundLayer.strokeEnd = CGFloat(to)

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = to
        animation.duration = 5

        foregroundLayer.add(animation, forKey: "foregroundAnimation")
    }

    // MARK: Private

    private let foregroundLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()

    private var radius: CGFloat {
        let value = frame.width < frame.height ? frame.width : frame.height
        return (value - lineWidth) / 2
    }

    private var pathCenter: CGPoint { return convert(center, from: superview) }
    private func setupView() {
        layer.sublayers = nil
        drawBackgroundLayer()
        drawForegroundLayer()
    }

    private func drawForegroundLayer() {
        let startAngle = (-CGFloat.pi / 2)
        let endAngle = 2 * CGFloat.pi + startAngle

        let path = UIBezierPath(arcCenter: pathCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        foregroundLayer.lineCap = .round
        foregroundLayer.path = path.cgPath
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.strokeColor = UIColor.white.cgColor
        foregroundLayer.strokeEnd = 0

        layer.addSublayer(foregroundLayer)
    }

    private func drawBackgroundLayer() {
        let startAngle = (-CGFloat.pi / 2)
        let endAngle = 2 * CGFloat.pi + startAngle

        let path = UIBezierPath(arcCenter: pathCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        backgroundLayer.lineCap = .round
        backgroundLayer.path = path.cgPath
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.strokeEnd = 5

        layer.addSublayer(backgroundLayer)
    }

    // Layout Sublayers
    private var layoutDone = false
    public override func layoutSublayers(of layer: CALayer) {
        if !layoutDone {
            setupView()
            layoutDone = true
        }
    }
}
