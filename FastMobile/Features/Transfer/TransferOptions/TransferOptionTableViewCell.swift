//
//  TransferOptionTableViewCell.swift
//  FastMobile
//
//  Created by Dinh Duong on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import SnapKit

class TransferOptionTableViewCell: UITableViewCell {
    // MARK: - Views
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textColor = UIColor.black.withAlphaComponent(0.85)
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        
        return label
    }()
    
    var transferOption: TransferOption? {
        didSet {
            guard let option = transferOption else { return }
            iconImageView.image = UIImage(named: option.iconName)
            titleLabel.text = option.title
            descriptionLabel.text = option.detail
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TransferOptionTableViewCell {
    
    func setupLayout() {
        selectionStyle = .none
        
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(48)
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.top.equalTo(iconImageView.snp.top)
            make.trailing.equalToSuperview()
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(1)
        }
    }
}
