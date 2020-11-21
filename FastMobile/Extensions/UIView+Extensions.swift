//
//  UIView+Extensions.swift
//  TCBPay
//
//  Created by Duong Dinh on 7/30/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import UIKit

extension UIApplication {
    
    func getKeyWindow() -> UIWindow? {
        if #available(iOS 13, *) {
            return windows.first { $0.isKeyWindow }
        } else {
            return keyWindow
        }
    }
    
    var safeAreaInsetsTop: CGFloat {
        let window = getKeyWindow()
        
        if #available(iOS 11.0, *) {
            return window?.safeAreaInsets.top ?? 0
        }
        return 0
    }
    
    var safeAreaInsetsBottom: CGFloat {
        let window = getKeyWindow()
        if #available(iOS 11.0, *) {
            return window?.safeAreaInsets.bottom ?? 0
        }
        return 0
    }
}

extension UIView {
    
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
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        } else {
            return topAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomAnchor
        }
    }
    
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leadingAnchor
        } else {
            return leadingAnchor
        }
    }
    
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.trailingAnchor
        } else {
            return trailingAnchor
        }
    }
    
    func dropShawdow(shadowRadius: CGFloat = 8, offSet: CGSize = CGSize(width: 2, height: 2)) {
        clipsToBounds = false
        layer.masksToBounds = false
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor
        layer.shadowOffset = offSet
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
    func fitToSuperview(inset: UIEdgeInsets = .zero) {
        guard let parent = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        leadingAnchor.constraint(equalTo: parent.safeLeadingAnchor, constant: inset.left).isActive = true
        trailingAnchor.constraint(equalTo: parent.safeTrailingAnchor, constant: -inset.right).isActive = true
        topAnchor.constraint(equalTo: parent.safeTopAnchor, constant: inset.top).isActive = true
        bottomAnchor.constraint(equalTo: parent.safeBottomAnchor, constant: -inset.bottom).isActive = true
    }
}

extension UIView {

    func applyGradient(cornerRadius: CGFloat = 20, isVertical: Bool, colorArray: [UIColor]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
         
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isVertical {
            //top to bottom
            gradientLayer.locations = [0.0, 1.0]
        } else {
            //left to right
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        backgroundColor = .clear
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }

}

extension UIView {
    func capture() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}

extension UIView {
    func addBorders(edges: [UIRectEdge],
                    color: UIColor = .white,
                    width: CGFloat = 1.0,
                    constant: CGFloat = 0) {
        edges.forEach { addBorder(edge: $0,
                                 color: color,
                                 width: width,
                                 constant: constant) }
    }
    
    func addBorder(edge: UIRectEdge,
                   color: UIColor = .white,
                   width: CGFloat = 1.0,
                   constant: CGFloat = 0) {
        let border = UIView(frame: .zero)
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        addSubview(border)
        bringSubviewToFront(border)
        
        switch edge {
        case .left:
            border.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            border.topAnchor.constraint(equalTo: topAnchor, constant: constant).isActive = true
            border.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constant).isActive = true
            border.widthAnchor.constraint(equalToConstant: width).isActive = true
        case .right:
            border.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            border.topAnchor.constraint(equalTo: topAnchor, constant: constant).isActive = true
            border.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constant).isActive = true
            border.widthAnchor.constraint(equalToConstant: width).isActive = true
        case .top:
            border.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constant).isActive = true
            border.topAnchor.constraint(equalTo: topAnchor).isActive = true
            border.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -constant).isActive = true
            border.heightAnchor.constraint(equalToConstant: width).isActive = true
        case .bottom:
            border.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constant).isActive = true
            border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            border.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -constant).isActive = true
            border.heightAnchor.constraint(equalToConstant: width).isActive = true
        default:
            layer.borderColor = color.cgColor
            layer.borderWidth = width
        }
    }
}

extension UIActivityIndicatorView {
    
    func hideLoading() {
        if Thread.isMainThread {
            stopAnimating()
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.stopAnimating()
            }
        }
    }
    
    func showLoading() {
        if Thread.isMainThread {
            superview?.bringSubviewToFront(self)
            startAnimating()
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.superview?.bringSubviewToFront(strongSelf)
                strongSelf.startAnimating()
            }
        }
    }
}
