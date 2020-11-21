//
//  RectangleButton.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 9/24/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import UIKit

final class RectangleButton: UIButton {
    private var background: UIColor? = .black
    private var color: UIColor? = .white
    
    convenience init(title: String?,
                     font: UIFont?,
                     color: UIColor? = .white,
                     background: UIColor? = .black,
                     cornerRadius: CGFloat = 8) {
        self.init(frame: .zero)
        
        titleLabel?.font = font
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        backgroundColor = background
        layer.cornerRadius = cornerRadius
        
        self.background = background
        self.color = color
    }
    
    override public var isUserInteractionEnabled: Bool {
        didSet {
            if isUserInteractionEnabled {
                backgroundColor = background
                setTitleColor(color, for: .normal)
            } else {
                backgroundColor = .segmentBackground
                setTitleColor(UIColor.black.withAlphaComponent(0.38), for: .normal)
            }
        }
    }
}
