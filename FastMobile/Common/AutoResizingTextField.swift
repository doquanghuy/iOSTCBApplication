//
//  AutoResizingTextField.swift
//  FastMobile
//
//  Created by duc on 9/19/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit

class AutoResizingTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        addTarget(self, action: #selector(textFieldTextDidChange(textField:)), for: .editingChanged)
    }

    @objc func textFieldTextDidChange(textField: UITextField) {
        textField.invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        if isEditing {
            let textSize = (text ?? placeholder ?? "").size(withAttributes: typingAttributes)
            return CGSize(
                width: textSize.width + (leftView?.bounds.size.width ?? 0) + (rightView?.bounds.size.width ?? 0) + 2,
                height: textSize.height
            )
        }
        return super.intrinsicContentSize
    }
}
