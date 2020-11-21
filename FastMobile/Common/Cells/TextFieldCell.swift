//
//  TextFieldCell.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 9/24/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import UIKit

final class TextFieldCell: BaseCell {
    
    private lazy var textField: CustomTextField = {
        let textField = CustomTextField(frame: .zero)
        textField.font = .regularFont(16)
        textField.textColor = .black
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(textField)
        textField.fitToSuperview(inset: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        textField.addTarget(self, action: #selector(textValueChanged(_:)), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup(with dataSource: DataSource? = nil, index: IndexPath = IndexPath(item: 0, section: 0), actionHandler: CellActionProtocol? = nil) {
        super.setup(with: dataSource, index: index, actionHandler: actionHandler)
        
        guard let config = dataSource?.items?[safe: index.item] as? TextFieldConfig else {
            return
        }
        
        textField.config = config
        
        if let leftView = textField.leftView {
            if config.tappable ?? false {
                let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLeftView))
                leftView.addGestureRecognizer(tap)
            } else {
                leftView.isUserInteractionEnabled = false
            }
        }
        
        if let rightView = textField.rightView {
            if config.tappable ?? false {
                let tap = UITapGestureRecognizer(target: self, action: #selector(didTapRigthView))
                rightView.addGestureRecognizer(tap)
                rightView.isUserInteractionEnabled = true
            } else {
                rightView.isUserInteractionEnabled = false
            }
        }
    }
    
    @objc private func textValueChanged(_ textField: UITextField) {
        actionHandler?.textValueChanged(textField.text, at: indexPath)
    }
    
    @objc private func didTapLeftView() {
        actionHandler?.didTapLeftView(textField.text, at: indexPath)
    }
    
    @objc private func didTapRigthView() {
        actionHandler?.didTapRightView(textField.text, at: indexPath)
    }
}

struct TextFieldConfig {
    var text: String?
    var leftView: UIView?
    var rightView: UIView?
    let placeHolder: String?
    let keyboardType: UIKeyboardType
    let inputHandler: TextInputHandler?
    let tappable: Bool
    let editable :Bool
    
    init(text: String? = nil,
         placeHolder: String? = nil,
         leftView: UIView? = nil,
         rightView: UIView? = nil,
         keyboardType: UIKeyboardType = .default,
         inputHandler: TextInputHandler? = nil,
         tappable: Bool = false,
         editable: Bool = true) {
        
        self.text = text
        self.placeHolder = placeHolder
        self.leftView = leftView
        self.rightView = rightView
        self.keyboardType = keyboardType
        self.inputHandler = inputHandler
        self.tappable = tappable
        self.editable = editable
    }
}

private final class CustomTextField: UITextField {
    
    var config: TextFieldConfig? {
        didSet {
            text = config?.text
            leftView = config?.leftView
            leftViewMode = .always
            rightView = config?.rightView
            rightViewMode = .always
            placeholder = config?.placeHolder
            keyboardType = config?.keyboardType ?? .default
            delegate = config?.inputHandler
            isUserInteractionEnabled = config?.editable ?? false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addBorder(edge: .bottom, color: UIColor.line)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
