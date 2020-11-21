//
//  TransferOptionTableViewCell.swift
//  FastMobile
//
//  Created by Dinh Duong on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class AccountOptionTableViewCell: UITableViewCell {
    // MARK: - Views
    lazy var accountTypeLabel: UILabel = {
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
    
    lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textColor = UIColor.black.withAlphaComponent(0.85)
        label.textAlignment = .right
        
        return label
    }()
    
    lazy var checkmarkIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_checkmark")
        
        return imageView
    }()
    
    var accountOption: AccountOption? {
        didSet {
            guard let option = accountOption else { return }
            accountTypeLabel.text = "\(option.amount.formattedNumber ?? "0") đ"
            descriptionLabel.text = option.type.name ?? option.name
            amountLabel.text = nil
            iconImageView.image = option.type.icon
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            backgroundColor = UIColor.black.withAlphaComponent(0.02)
            checkmarkIconImageView.isHidden = false
        } else {
            backgroundColor = UIColor.white
            checkmarkIconImageView.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountOptionTableViewCell {
    
    func setupLayout() {
        
        contentView.addSubview(accountTypeLabel)
        accountTypeLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(47)
            make.top.equalToSuperview().inset(8)
        }
        
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints({ (make) in
            make.centerY.equalTo(accountTypeLabel.snp.centerY)
            make.width.height.equalTo(22)
            make.leading.equalToSuperview().inset(17)
        })
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.width.equalTo(255)
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.top.equalTo(accountTypeLabel.snp.bottom).offset(5)
        }
        
        contentView.addSubview(checkmarkIconImageView)
        checkmarkIconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(24)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(checkmarkIconImageView.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(accountTypeLabel.snp.trailing).offset(8)
        }
        
    }
}
