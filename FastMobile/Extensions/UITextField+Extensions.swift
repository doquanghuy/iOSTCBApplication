//
//  UITextField+Extensions.swift
//  CustomKeyboard
//
//  Created by Pham Thanh Hoa on 9/21/20.
//  Copyright © 2020 Pham Thanh Hoa. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension UITextField {
    
    func setupCustomNumberKeyboard(with width: CGFloat) {
        
        let keyboard = NumberKeyboardView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        keyboard.delegate = self
        inputView = keyboard
        
        let accessoryView = SuggestedAmountView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        accessoryView.textField = self
        inputAccessoryView = accessoryView
        
        delegate = TextInputHandler.amount
    }
}

extension UITextField: NumberKeyboardProtocol {
    func didTapKey(_ key: Key) {
        var currentText = text ?? ""
        
        switch key.type {
        case .delete:
            if !currentText.isEmpty {
                currentText.removeLast()
                text = currentText.formattedNumber
            }
        case .enter:
            resignFirstResponder()
        default:
            let newText = "\(currentText)\(String(describing: key.value ?? ""))"
            let value = newText.doubleValue
            
            guard value > 0, value.originString.count <= 12 else { return }
            
            text = newText.formattedNumber
        }
        
        self.sendActions(for: .valueChanged)
        if let accessoryView = inputAccessoryView as? SuggestedAmountView {
            accessoryView.inputKey = text
        }
    }
}

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
