//
//  PasscodeCollectionViewCell.swift
//  FastMobile
//
//  Created by Duong Dinh on 10/7/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import SnapKit

enum TCBPasscodeSetupAttempt {
    case initial
    case confirm
}

enum TCBPasscodeType {
    case firstTimeInstall
    case login
}

class TCBPasscodeButton: UIButton {
    
    var indexPath: IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Helvetica Neue", size: 27)
        showsTouchWhenHighlighted = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TCBPasscodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "TCBPasscodeCollectionViewCell"
    
    /// Number button
    lazy var numberButton: TCBPasscodeButton = {
        let button = TCBPasscodeButton(type: .custom)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        contentView.addSubview(numberButton)
        numberButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(-1)
        }
    }
    
    func setupUI() {
        contentView.bringSubviewToFront(numberButton)
        contentView.backgroundColor = .clear
        layer.cornerRadius = frame.width / 2
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
    }
}
