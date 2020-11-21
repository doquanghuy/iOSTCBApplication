//
//  UIAnimatableLabel.swift
//  FastMobile
//
//  Created by vuong on 10/22/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//


import UIKit


@IBDesignable
public class TCBAnimatableLabel: UIView {
    private var widthConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    private var dummyLabel: UILabel = {
        UILabel()
    }()

    var text: String? {
        set {
            let newText: NSString = NSString(string: newValue ?? "")
            self.adjustSizeLb(with: text)
            textLayer.string = newValue
            layoutIfNeeded()
        }
        get {
            return textLayer.string as? String
        }
    }
    
    private func adjustSizeLb(with text: String?) {
        let content: NSString = NSString(string: text ?? "")
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude,
                                    height: CGFloat.greatestFiniteMagnitude)
        let boundingRect = content.boundingRect(with: constraintRect,
                                                options: .usesLineFragmentOrigin,
                                                attributes: [.font: font],
                                                context: nil)
        widthConstraint.constant = boundingRect.width
        heightConstraint.constant = boundingRect.height
        layoutIfNeeded()
    }

    var textColor: UIColor! {
        set {
            textLayer.foregroundColor = newValue.cgColor
        }
        get {
            guard let cgColor = textLayer.foregroundColor else {
                return .clear
            }
            return UIColor(cgColor: cgColor)
        }
    }

    var font = DefaultDesign.fonts.defaultFont(ofSize: 32) {
        didSet {
            let fontName = font.fontName as NSString
            textLayer.font = CGFont(fontName)
            textLayer.fontSize = font.pointSize
            self.adjustSizeLb(with: text)
        }
    }

    var textLayer: CATextLayer = {
        let textLayer = CATextLayer()
        textLayer.contentsScale = UIScreen.main.scale
        return textLayer
    }()

    public override var backgroundColor: UIColor? {
        set {
            super.backgroundColor = newValue
            textLayer.backgroundColor = newValue?.cgColor
        }
        get {
            return super.backgroundColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initial()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initial()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        textLayer.frame = bounds
    }

    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initial()
    }

    private func initial() {
        widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal,
                                             toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: dummyLabel.bounds.width)
        heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal,
                                              toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: dummyLabel.bounds.height)

        layer.addSublayer(textLayer)
        NSLayoutConstraint.activate([widthConstraint, heightConstraint])
    }
}
