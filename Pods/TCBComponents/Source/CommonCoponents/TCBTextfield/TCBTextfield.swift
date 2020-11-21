//
//  TCBTextfield.swift
//  FastMobile
//
//  Created by vuong on 10/22/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit


public protocol TCBTextFieldInterface {
    var animationSpeed: TimeInterval { get set }
    var activeLineWidth: CGFloat { get set }
    var activeLineColor: UIColor { get set }
    var activePlaceholderTextColor: UIColor { get set }
    var inactiveLineWidth: CGFloat { get set }
    var inactiveLineColor: UIColor { get set }
    var inactivePlaceholderTextColor: UIColor { get set }
    var errorLineColor: UIColor { get set }
    var errorColor: UIColor { get set }
    var errorNumberOfLines: Int { get set }
    var text: String? { get set }
    var placeholder: String? { get set }
    var placeholderActive: String? { get set }
    var placeholderInactive: String? { get set }
    var font: UIFont? { get set }
    var placeholderFontActive: UIFont { get set }
    var placeholderFontInactive: UIFont { get set }
    var errorFont: UIFont { get set }
    var clearButtonMode: UITextField.ViewMode { get set }
    var leftView: UIView? { get set }
    var rightView: UIView? { get set }
}

@IBDesignable
public class TCBTextField: UITextField, TCBTextFieldInterface {
    
    public var animationSpeed: TimeInterval = 0.3
    
    @IBInspectable public var activeLineWidth: CGFloat = 1 {
        didSet {
            if oldValue != activeLineWidth {
                lineView.heightAnchor.constraint(equalToConstant: lineWidth).isActive = true
                setNeedsUpdateConstraints()
            }
        }
    }

    @IBInspectable public var activeLineColor: UIColor = .darkText {
        didSet {
            if oldValue != activeLineColor {
                setNeedsUpdateConstraints()
            }
        }
    }

    @IBInspectable public var activePlaceholderTextColor: UIColor = .lightText {
        didSet {
            if oldValue != activeLineColor {
                placeholderLabel.textColor = placeholderColor
                setNeedsDisplay()
            }
        }
    }

    @IBInspectable public var inactiveLineWidth: CGFloat = 1 {
        didSet {
            if oldValue != inactiveLineWidth {
                setNeedsDisplay()
            }
        }
    }

    @IBInspectable public var inactiveLineColor: UIColor = .lightText {
        didSet {
            if oldValue != inactiveLineColor {
                setNeedsDisplay()
            }
        }
    }

    @IBInspectable public var inactivePlaceholderTextColor: UIColor = .darkText {
        didSet {
            if oldValue != activeLineColor {
                placeholderLabel.textColor = placeholderColor
                setNeedsDisplay()
            }
        }
    }

    @IBInspectable public var errorLineColor: UIColor = UIColor.clear {
        didSet {
            if oldValue != errorLineColor {
                setNeedsDisplay()
            }
        }
    }

    @IBInspectable public var errorColor: UIColor = UIColor.clear {
        didSet {
            if oldValue != errorColor {
                errorLabel.textColor = errorColor
                setNeedsDisplay()
            }
        }
    }

    @IBInspectable public var errorNumberOfLines: Int = 1 {
        didSet {
            if oldValue != errorNumberOfLines {
                errorLabel.numberOfLines = errorNumberOfLines
                if errorNumberOfLines > 1 {
                    errorLabel.lineBreakMode = .byWordWrapping
                } else {
                    errorLabel.lineBreakMode = .byTruncatingTail
                }
                setNeedsDisplay()
            }
        }
    }

    private var placeholderColor: UIColor! {
        return isPlaceholderUp ? activePlaceholderTextColor : inactivePlaceholderTextColor
    }

    public override var text: String? {
        didSet {
            super.text = text
            isPlaceholderUp = text?.isEmpty == false
            setNeedsDisplay()
        }
    }

    public override var placeholder: String? {
        set {
            placeholderInactive = newValue
            placeholderLabel.text = currentPlaceholder
        }
        get { return placeholderInactive }
    }

    public var placeholderActive: String?
    public var placeholderInactive: String?

    private var currentPlaceholder: String? {
        return isPlaceholderUp ? placeholderActive ?? placeholderInactive : placeholderInactive
    }

    public override var font: UIFont? {
        set {
            super.font = newValue
            adjustHeight()
        }
        get {
            return super.font
        }
    }

    public var placeholderFontActive: UIFont = DefaultDesign.fonts.defaultFont(ofSize: 12) {
        didSet {
            placeholderLabel.font = placeholderFont
        }
    }

    public var placeholderFontInactive: UIFont = DefaultDesign.fonts.defaultFont(ofSize: 15) {
        didSet {
            placeholderLabel.font = placeholderFont
        }
    }

    private var placeholderFont: UIFont {
        return isPlaceholderUp ? placeholderFontActive : placeholderFontInactive
    }

    public var errorFont: UIFont = DefaultDesign.fonts.defaultFont(ofSize: 12) {
        didSet {
            errorLabel.font = errorFont
        }
    }

    public override var clearButtonMode: UITextField.ViewMode {
        set {
            rightViewMode = newValue
        }
        get {
            return rightViewMode
        }
    }

    public override var tintColor: UIColor! {
        set {
            super.tintColor = newValue
            clearButton.tintColor = newValue
        }
        get {
            return super.tintColor
        }
    }

    private var neededConstraint = [NSLayoutConstraint]()
    private var heightConstraint: NSLayoutConstraint!
    private var placeholderXPositionConstraint: NSLayoutConstraint!
    private var placeholderPositionConstraint: NSLayoutConstraint!
    private var linePositionConstraint: NSLayoutConstraint!
    private var isPlaceholderUp: Bool = false {
        didSet {
            guard oldValue != isPlaceholderUp else { return }

            placeholderPositionConstraint.constant = isPlaceholderUp ? -25 : 0
            setNeedsUpdateConstraints()
            UIView.animate(withDuration: animationSpeed, animations: {
                self.placeholderLabel.font = self.placeholderFont
                self.placeholderLabel.text = self.currentPlaceholder
                self.placeholderLabel.textColor = self.placeholderColor
                self.layoutIfNeeded()
            })
        }
    }

    private var isErrorLabelVisibile = false {
        didSet {
            if oldValue != isErrorLabelVisibile {
                UIView.animate(withDuration: animationSpeed, animations: {
                    self.errorLabel.alpha = self.isErrorLabelVisibile ? 1 : 0
                })
            }
        }
    }

    private var lineColor: UIColor {
        switch status {
        case .active:
            return activeLineColor
        case .error:
            return errorLineColor
        case .inactive:
            return inactiveLineColor
        }
    }

    private var lineWidth: CGFloat {
        switch status {
        case .active:
            return activeLineWidth
        default:
            return inactiveLineWidth
        }
    }

    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .custom)
        let clearImage = UIImage(named: "iconClearWhite")
        button.setImage(clearImage, for: .normal)
        button.setImage(clearImage, for: .highlighted)
        button.addTarget(self, action: #selector(self.clearText), for: .touchUpInside)
        button.tintColor = tintColor
        button.sizeToFit()
        rightView = button
        return button
    }()

    private var leftPadding: CGFloat = 16

    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = self.errorLineColor
        label.numberOfLines = 1
        label.font = errorFont

        neededConstraint.append(NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal,
                                                   toItem: placeholderLabel, attribute: .leading, multiplier: 1, constant: 0))
        neededConstraint.append(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal,
                                                   toItem: lineView, attribute: .bottom, multiplier: 1, constant: 4))
        neededConstraint.append(NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal,
                                                   toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        return label
    }()

    private lazy var placeholderLabel: TCBAnimatableLabel = {
        let label = TCBAnimatableLabel()
        label.font = self.font ?? DefaultDesign.fonts.defaultFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        placeholderPositionConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal,
                                                           toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        placeholderXPositionConstraint = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal,
                                                            toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        neededConstraint.append(placeholderXPositionConstraint)
        neededConstraint.append(placeholderPositionConstraint)
        neededConstraint.append(NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal,
                                                   toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        return label
    }()

    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = lineColor
        neededConstraint.append(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal,
                                                   toItem: placeholderLabel, attribute: .leading, multiplier: 1, constant: 0))
        linePositionConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                                    toItem: self, attribute: .bottom, multiplier: 1, constant: -10)
        neededConstraint.append(linePositionConstraint)
        neededConstraint.append(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal,
                                                   toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        view.heightAnchor.constraint(equalToConstant: lineWidth).isActive = true
        return view
    }()

    public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = super.leftViewRect(forBounds: bounds)
        newBounds.size.width = 40
        return newBounds
    }

    public var status: Status = .inactive {
        didSet {
            isErrorLabelVisibile = false
            switch status {
            case let .error(message):
                errorLabel.text = message
                isErrorLabelVisibile = true
            default:
                break
            }
            lineView.backgroundColor = lineColor
            adjustHeight()
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initilize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initilize()
    }

    private func initilize() {
        borderStyle = .none
        placeholder = super.placeholder
        tintColor = super.tintColor
        super.placeholder = nil
        clearButtonMode = super.clearButtonMode
        placeholderLabel.text = currentPlaceholder
        addTarget(self, action: #selector(formTextFieldDidBeginEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(formTextFieldDidEndEditing), for: .editingDidEnd)
        addTarget(self, action: #selector(formTextFeildValueChanged), for: [.editingChanged, .valueChanged])
        addSubview(placeholderLabel)
        addSubview(lineView)
        addSubview(errorLabel)
        adjustHeight()
        NSLayoutConstraint.activate(neededConstraint)
        errorLabel.alpha = 0
    }
}

extension TCBTextField {
    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        lineView.backgroundColor = lineColor
        placeholderLabel.textColor = placeholderColor
        placeholderXPositionConstraint.constant = leftView?.frame.maxX ?? 0
        layoutIfNeeded()
    }
}

public extension TCBTextField {
    func adjustHeight() {
        if heightConstraint == nil {
            heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
            heightConstraint.isActive = true
        }
        let isEmpty = errorLabel.text?.isEmpty ?? true
        heightConstraint.constant = isEmpty ? 64 : 72
    }

    @objc private func clearText() {
        guard delegate?.textFieldShouldClear?(self) ?? true else {
            return
        }
        text = ""
        isPlaceholderUp = false
    }
}

extension TCBTextField {
    @objc private func formTextFieldDidBeginEditing() {
        layoutIfNeeded()
        status = .active
    }

    @objc private func formTextFieldDidEndEditing() {
        layoutIfNeeded()
        status = .inactive
    }

    @objc private func formTextFeildValueChanged() {
        guard let text = text, !text.isEmpty else {
            isPlaceholderUp = false
            return
        }
        isPlaceholderUp = true
    }
}

public extension TCBTextField {
    enum Status {
        case active
        case error(message: String)
        case inactive
    }
}
