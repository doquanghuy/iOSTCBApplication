//
//  TCBPasscodeView.swift
//  Alamofire
//
//  Created by Pham Thanh Hoa on 11/2/20.
//

import Foundation
import UIKit
import SnapKit

public class TCBPasscodeView: UIView {
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.delegate = self
        
        return field
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let numberOfDigits: Int
    private let emptyColor: UIColor
    private let checkedColor: UIColor
    
    public init(numberOfDigits: Int,
         emptyColor: UIColor = .gray,
         checkedColor: UIColor = .black) {
        
        self.numberOfDigits = numberOfDigits
        self.emptyColor = emptyColor
        self.checkedColor = checkedColor
        
        super.init(frame: .zero)
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupLayouts()
    }
    
    private func setupLayouts() {
        
        addSubview(textField)
        textField.isHidden = true
        
        textField.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        let minMargin: CGFloat = 20.0
        let interItemSpacing: CGFloat = 10.0
        let preferredDigitViewWidth: CGFloat = 30.0

        let availableWidth = bounds.width - (2 * minMargin) - (CGFloat(numberOfDigits - 1) * interItemSpacing)
        let calculatedWidth = availableWidth / CGFloat(numberOfDigits)

        let digitViewWidth = (calculatedWidth >= preferredDigitViewWidth) ? preferredDigitViewWidth : calculatedWidth
        let digitViewHeight = digitViewWidth

        for i in 0 ..< numberOfDigits {
            let digitView = CheckboxView()
            digitView.tag = Int(i)
            digitView.emptyColor = emptyColor
            digitView.checkedColor = checkedColor
            digitView.snp.makeConstraints { make in
                make.width.equalTo(digitViewWidth)
                make.height.equalTo(digitViewWidth)
            }
            stackView.addArrangedSubview(digitView)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onTap() {
        textField.becomeFirstResponder()
    }
}

extension TCBPasscodeView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        var shouldChange = false
        
        guard let textFieldText = textField.text else {
            return numberOfDigits > 0
        }

        let newStringLength = textFieldText.count - range.length + string.count

        if string.isEmpty, range.length > 0 {
            shouldChange = true // We allways allow deletion.
        }

        if range.length < string.count, newStringLength > numberOfDigits {
            shouldChange = false // Don't allow too many digits.
        } else {
            shouldChange = true
        }

        if shouldChange {
            updateViewForActiveDigitCount(newStringLength)
        }

        if newStringLength == numberOfDigits {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                // Calling resignFirstResponder too soon will delay the last digit appearing.
                self.textField.resignFirstResponder()
                self.shakeDigits()
                self.resetPins()
            }
        }

        return shouldChange
    }
}

extension TCBPasscodeView {
    internal func updateViewForActiveDigitCount(_ activeDigitCount: Int) {
        for case let digitView as CheckboxView in stackView.arrangedSubviews {
            digitView.isChecked = digitView.tag < activeDigitCount
        }
    }
    
    internal func shakeDigits() {
        let animation = CAKeyframeAnimation.horizontalShake(in: stackView.frame,
                                                            numberOfShakes: 9,
                                                            vigour: 3.0,
                                                            duration: 0.6)
        stackView.layer.add(animation, forKey: "shake")
    }
    
    internal func resetPins() {
        textField.text = ""
        updateViewForActiveDigitCount(0)
    }
}
