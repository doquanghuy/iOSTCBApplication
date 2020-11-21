//
//  BeneficiaryTableViewCell.swift
//  FastMobile
//
//  Created by Dinh Duong on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import SnapKit

class BeneficiaryTableViewCell: UITableViewCell {
    // MARK: - Views
    lazy var avatarIconView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var firstLetterAccountNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textColor = UIColor.black.withAlphaComponent(0.38)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var detailImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var accountNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textColor = UIColor.black.withAlphaComponent(0.85)
        
        return label
    }()
    
    lazy var bankLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        
        return label
    }()
    
    lazy var accountIDLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        
        return label
    }()
    
    lazy var likeIconImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        
        return view
    }()
    
    var beneficiary: Beneficiary? {
        didSet {
            guard let model = beneficiary else { return }
            accountNameLabel.text = model.accountName
            accountIDLabel.text = model.accountId
            bankLabel.text = model.bankName
            firstLetterAccountNameLabel.text = String(model.accountName.first!)
            detailImageView.image = UIImage(named: model.bankIcon)
            let rightImageName = model.isFavorited ? "ic_heart_filled" : "ic_heart"
            likeIconImageView.image = UIImage(named: rightImageName)
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

// MARK: - Setup
extension BeneficiaryTableViewCell {
    
    func setupLayout() {
        selectionStyle = .none
        
        contentView.addSubview(avatarIconView)
        avatarIconView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.width.height.equalTo(48)
            make.centerY.equalToSuperview()
        }
        
        avatarIconView.addSubview(firstLetterAccountNameLabel)
        firstLetterAccountNameLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(12)
        }
        
        contentView.addSubview(detailImageView)
        detailImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(24)
            make.leading.equalTo(avatarIconView.snp.leading).offset(28)
            make.top.equalTo(avatarIconView.snp.top).offset(30)
        }
        
        contentView.addSubview(accountNameLabel)
        accountNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(avatarIconView.snp.trailing).offset(16)
            make.top.equalToSuperview().inset(8)
            make.width.equalTo(199)
        }
        
        contentView.addSubview(bankLabel)
        bankLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(accountNameLabel.snp.leading)
            make.top.equalTo(accountNameLabel.snp.bottom).offset(1)
            make.width.equalTo(180)
        }
        
        contentView.addSubview(accountIDLabel)
        accountIDLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(bankLabel.snp.leading)
            make.top.equalTo(bankLabel.snp.bottom).offset(1)
        }
        
        contentView.addSubview(likeIconImageView)
        likeIconImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(42)
            make.width.height.equalTo(20)
            make.leading.greaterThanOrEqualTo(accountNameLabel.snp.trailing).offset(34)
            make.centerY.equalTo(bankLabel.snp.centerY)
        }
        
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.leading.equalTo(bankLabel.snp.leading)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
