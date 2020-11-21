//
//  UIView.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/12/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit

protocol ShadowableRoundableView {
    
    var cornerRadius: CGFloat { get set }
    var shadowColor: UIColor { get set }
    var shadowOffsetWidth: CGFloat { get set }
    var shadowOffsetHeight: CGFloat { get set }
    var shadowOpacity: Float { get set }
    var shadowRadius: CGFloat { get set }
    
    var shadowLayer: CAShapeLayer { get }
    
    func setCornerRadiusAndShadow()
}

extension ShadowableRoundableView where Self: UIView {
    func setCornerRadiusAndShadow() {
        layer.cornerRadius = cornerRadius
        shadowLayer.path = UIBezierPath(roundedRect: bounds,
                                            cornerRadius: cornerRadius ).cgPath
        shadowLayer.fillColor = backgroundColor?.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: shadowOffsetWidth ,
                                          height: shadowOffsetHeight )
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowRadius
    }
}

@IBDesignable
class CustomView: UIView, ShadowableRoundableView {
    
    @IBInspectable var cornerRadius: CGFloat = 16 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowOffsetWidth: CGFloat = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
     
    @IBInspectable var shadowOffsetHeight: CGFloat = 2 {
        didSet {
            self.setNeedsLayout()
        }
    }
      
    @IBInspectable var shadowOpacity: Float = 0.08 {
        didSet {
            self.setNeedsLayout()
        }
    }
     
    @IBInspectable var shadowRadius: CGFloat = 16 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    private(set) lazy var shadowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.insertSublayer(layer, at: 0)
        self.setNeedsLayout()
        return layer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setCornerRadiusAndShadow()
    }
}
