//
//  SuggestedKeyboardCell.swift
//  CustomKeyboard
//
//  Created by Pham Thanh Hoa on 9/19/20.
//  Copyright © 2020 Pham Thanh Hoa. All rights reserved.
//

import Foundation
import UIKit

final class SuggestedKeyboardCell: UICollectionViewCell {
    
    private lazy var content: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var key: String? {
        didSet {
            guard let key = key else { return }
            content.text = key
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        layer.borderColor = UIColor.grayBackground.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 8
        
        addSubview(content)
        content.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        content.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
