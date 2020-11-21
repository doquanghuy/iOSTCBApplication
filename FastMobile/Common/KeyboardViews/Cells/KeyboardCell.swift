//
//  KeyboardCell.swift
//  CustomKeyboard
//
//  Created by Pham Thanh Hoa on 9/18/20.
//  Copyright © 2020 Pham Thanh Hoa. All rights reserved.
//

import Foundation
import UIKit

final class KeyboardCell: UICollectionViewCell {
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let text: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var key: Key? {
        didSet {
            guard let key = key else { return }
            
            backgroundColor = key.type.backgroundColor
            
            if let img = key.type.icon {
                image.image = img
                image.isHidden = false
                text.isHidden = true
            } else {
                text.text = key.value
                text.textColor = key.type.textColor
                text.font = key.type.font
                image.isHidden = true
                text.isHidden = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        
        addSubview(image)
        image.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        image.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(text)
        text.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        text.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
