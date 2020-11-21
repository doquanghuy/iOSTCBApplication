//
//  TextInputHandler.swift
//  CustomKeyboard
//
//  Created by Pham Thanh Hoa on 9/21/20.
//  Copyright © 2020 Pham Thanh Hoa. All rights reserved.
//

import Foundation
import UIKit

protocol TextInputHandlerProtocol: NSObjectProtocol {
    func textFieldInputFailed(_ handler: TextInputHandler, textField: UITextField)
    func textFieldInputSuccess(_ handler: TextInputHandler, textField: UITextField)
    func textFieldShouldBeginEditing(_ handler: TextInputHandler, textField: UITextField) -> Bool
}

extension TextInputHandlerProtocol {
    func textFieldInputFailed(_ handler: TextInputHandler, textField: UITextField) {}
    func textFieldInputSuccess(_ handler: TextInputHandler, textField: UITextField) {}
    func textFieldShouldBeginEditing(_ handler: TextInputHandler, textField: UITextField) -> Bool { return true }
}

final class TextInputHandler: NSObject, UITextFieldDelegate {
    private var maxCount: Int = Int.max
    private var characterSet: CharacterSet?
    private weak var delegate: TextInputHandlerProtocol?
    private var canStartWithZero: Bool = true
    
    override init() {
        super.init()
        
        maxCount = Int.max
    }
    
    convenience init(maxCount: Int = Int.max,
                     delegate: TextInputHandlerProtocol? = nil,
                     characterSet: CharacterSet? = nil,
                     canStartWithZero: Bool = true) {
        self.init()
        self.maxCount = maxCount
        self.delegate = delegate
        self.characterSet = characterSet
        self.canStartWithZero = canStartWithZero
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldBeginEditing(self, textField: textField) ?? true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let proposedText: String
        if let text = textField.text, let range = Range(range, in: text) {
            proposedText = text.replacingCharacters(in: range, with: string)
        } else {
            proposedText = ""
        }
        
        // Handle backspace/delete
        guard !string.isEmpty else {
            // Backspace detected, allow text change, no need to process the text any further
            if proposedText.isEmpty {
                delegate?.textFieldInputFailed(self, textField: textField)
            }
            
            return true
        }
        
        guard characterSet?.isSuperset(of: CharacterSet(charactersIn: string)) ?? true else {
            if proposedText.count <= maxCount {
                delegate?.textFieldInputFailed(self, textField: textField)
            }
            
            return false
        }

        // Check proposed text length does not exceed max character count
        guard proposedText.count <= maxCount else {
            // Character count exceeded, disallow text change
            if maxCount == 1 {
                textField.text = nil
                return true
            }
            
            return false
        }
        
        if !canStartWithZero, string == "0", proposedText == "0" {
            return false
        }

        // Allow text change
        delegate?.textFieldInputSuccess(self, textField: textField)
        
        return true
    }
}

extension TextInputHandler {
    static let amount = TextInputHandler(maxCount: 15,
                                         characterSet: CharacterSet(charactersIn: "0123456789"),
                                         canStartWithZero: false)
    static let accountId = TextInputHandler(maxCount: 15,
                                            characterSet: CharacterSet(charactersIn: "0123456789"))
}
