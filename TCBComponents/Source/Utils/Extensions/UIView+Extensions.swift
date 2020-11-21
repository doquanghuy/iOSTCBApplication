//
// Copyright © 2020 Backbase R&D B.V. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    enum Anchor {
        case left
        case top
        case right
        case bottom
    }

    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }
        return subviews.first(where: { $0.firstResponder != nil })?.firstResponder
    }

    // Convienience method to load a XIB for a class and return the view instance.
    // A XIB file has to have the same name as a class in order to load properly.
    static func loadNibForClass<T: UIView>(_ class: T.Type) -> T? {
        let nibName = String(describing: T.self)
        let bundle = Bundle(for: T.self)
        
        guard
            let views = bundle.loadNibNamed(nibName, owner: self, options: nil),
            let view = views.first as? T else {
                fatalError("failed to load nib '\(nibName)' from bundle '\(bundle)'")
        }

        return view
    }

    static func nib(bundle: Bundle? = nil) -> UINib? {
        return UINib(nibName: String(describing: Self.self), bundle: bundle)
    }

    /// Sets the left, right, top and bottom anchor, so the view fits it's container.
    /// - parameter container: The container for which this view will be a child of.
    /// - parameter anchors: The anchors that should be activated for the container.
    /// - parameter margins: The margins around view.
    func setFillingConstraints(in container: UIView,
                               anchors: [Anchor] = [.left, .top, .right, .bottom],
                               margins: UIEdgeInsets = UIEdgeInsets.zero) {
        translatesAutoresizingMaskIntoConstraints = false
        for anchor in anchors {
            switch anchor {
            case .left:
                leftAnchor.constraint(equalTo: container.leftAnchor, constant: margins.left).isActive = true
            case .top:
                topAnchor.constraint(equalTo: container.topAnchor, constant: margins.top).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: container.rightAnchor, constant: margins.right).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: margins.bottom).isActive = true
            }
        }
        setNeedsUpdateConstraints()
    }

    func setFillingWithCenterAlign(in container: UIView, multiplier: CGFloat = 1.0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true

        widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: multiplier).isActive = true
        heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: multiplier).isActive = true
    }

    func topAnchor(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
        let constraint = topAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }

    func bottomAnchor(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
        let constraint = bottomAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }

    func leftAnchor(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
        let constraint = leftAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }

    func rightAnchor(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
        let constraint = rightAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }

    func widthAnchor(to constant: CGFloat, priority: UILayoutPriority = .required) {
        let constraint = widthAnchor.constraint(equalToConstant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }

    func heightAnchor(to constant: CGFloat, priority: UILayoutPriority = .required) {
        let constraint = heightAnchor.constraint(equalToConstant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }

    func firstBaselineAnchor(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
        let constraint = firstBaselineAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }

    func leadingAnchor(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
        let constraint = leadingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }

    func trailingAnchor(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
        let constraint = trailingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }

    func centerXAnchor(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
        let constraint = centerXAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }

    func centerYAnchor(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
        let constraint = centerYAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }

    func aspectRatioAnchor(to constant: CGFloat) {
        addConstraint(NSLayoutConstraint(item: self,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .width,
                                         multiplier: constant,
                                         constant: 0))
    }

    func startShimmering(light: CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8492776113).cgColor,
                         dark: CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor) {
        let gradient = CAGradientLayer()

        gradient.colors = [dark, light, dark]
        gradient.frame = CGRect(x: -bounds.size.width,
                                y: 0,
                                width: 3 * bounds.size.width,
                                height: bounds.size.height)

        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.525)
        gradient.locations = [0.4, 0.5, 0.6]

        layer.mask = gradient

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1.5
        animation.repeatCount = Float.infinity

        gradient.add(animation, forKey: "shimmer")
    }

    func stopShimmering() {
        layer.mask = nil
    }
}

extension UIView {
    
    var parentViewController: UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder?.next
            guard let viewController = responder as? UIViewController else { continue }
            return viewController
        }
        return nil
    }
}

extension UIView {
    // MARK: - Shadow

    static var defaultShadowColor: UIColor {
        return UIColor.black.withAlphaComponent(0.33)
    }

    /// Apply shadow to the view
    /// - parameter radius: The blur radius (in points) used to render the layer’s shadow. Default value: 2
    /// - parameter opacity: The opacity of the layer’s shadow. Default value: 0.15
    /// - parameter offset: The offset (in points) of the layer’s shadow. Default value: CGSize(width: 0, height: 1)
    /// - parameter color: The color of the layer’s shadow. Default value: opaque black
    func applyShadow(radius: CGFloat = 2,
                     opacity: Float = 0.15,
                     offset: CGSize = CGSize(width: 0, height: 1),
                     color: UIColor = defaultShadowColor) {
        let layer = self.layer
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }

    func applyShadow(_ shadow: NSShadow) {
        let layer = self.layer
        layer.shadowOffset = shadow.shadowOffset
        layer.shadowRadius = shadow.shadowBlurRadius

        guard let shadowColor = shadow.shadowColor as? UIColor else { return }

        layer.shadowOpacity = Float(shadowColor.cgColor.alpha)
        layer.shadowColor = shadowColor.cgColor
    }

    /// Draw lines between given points
    /// - parameter p0: The starting point for the line.
    /// - parameter p1: The end point for the line
    /// - parameter isDottedLine: Boolean value to decide whether its dotted or concreate line. default is true.
    /// - parameter strokeColor: The color of the layer’s strokecolor.
    func drawLineBetween(start p0: CGPoint, end p1: CGPoint,
                         isDottedLine: Bool = true, strokeColor: CGColor) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = strokeColor
        let lineWidth = isDottedLine ? 2 : 4
        shapeLayer.lineWidth = CGFloat(lineWidth)

        if isDottedLine {
            shapeLayer.lineDashPattern = [3, 2]
        }

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        let layer = self.layer
        layer.insertSublayer(shapeLayer, at: 0)
    }
}

//extension UIView: Statable {
//    private static let stateViewTag = 6544
//    private static var storedState: String = ""
//    private struct CustomProperties {
//        static var dataSource: StatableDataSource?
//    }
//
//    public var stateDataSouce: StatableDataSource? {
//        get { return objc_getAssociatedObject(self, &CustomProperties.dataSource) as? StatableDataSource }
//        set { objc_setAssociatedObject(self, &CustomProperties.dataSource, newValue, .OBJC_ASSOCIATION_RETAIN) }
//    }
//
//    @discardableResult
//    public func addEdgeCaseView(for error: Error?) -> UIView? {
//        guard let stateDataSouce = self.stateDataSouce else { return nil }
//        let state = stateDataSouce.state(for: error)
//        return addEdgeCaseView(for: state)
//    }
//
//    @discardableResult
//    public func addEdgeCaseView(for state: StateType) -> UIView? {
//        guard let stateDataSouce = self.stateDataSouce else { return nil }
//
//        var view = viewWithTag(UICollectionView.stateViewTag)
//        if view != nil, UIView.storedState == state.rawValue {} else {
//            if let view = view, subviews.contains(view) {
//                view.removeFromSuperview()
//            }
//            view = { () -> UIView in
//                let view = stateDataSouce.stateView(for: state) ?? UIView()
//                view.tag = UICollectionView.stateViewTag
//                addSubview(view)
//                bringSubviewToFront(view)
//                view.frame = bounds
//                return view
//            }()
//        }
//
//        guard let statableView = view as? StatableView else { return view }
//
//        let image = stateDataSouce.image(for: state)
//        let title = stateDataSouce.title(for: state)
//        let message = stateDataSouce.message(for: state)
//        let buttonTitle = stateDataSouce.button(for: state)
//        let buttonAction = stateDataSouce.action(for: state)
//
//        statableView.setup(image: image, title: title, message: message, actionTitle: buttonTitle, action: buttonAction)
//        UIView.storedState = state.rawValue
//        return view
//    }
//}
