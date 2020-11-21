//
//  File.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 10/31/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import TCBComponents

final class OnboardCard: TCBCardBaseView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    init(title: NSAttributedString?, image: UIImage?) {
        super.init(accentColor: .clear, fillColor: .clear, frame: .zero)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).inset(16)
            make.trailing.equalTo(self.snp.trailing).inset(16)
            make.top.equalTo(self.snp.top).offset(84)
            make.height.equalTo(68)
        }
        titleLabel.attributedText = title
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.top.lessThanOrEqualTo(titleLabel.snp.bottom).offset(116)
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom)
            make.bottom.equalTo(self.snp.bottom).inset(48)
        }
        imageView.image = image
        
        bringSubviewToFront(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
