//
//  TCBMenuItems.swift
//  FastMobile
//
//  Created by vuong on 10/22/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit
//import SnapKit

public protocol TCBMenuItemProtocol {
    var iconName: String { get set }
    var title: String { get set }
    var detail: String { get set }
}

public protocol TCBMenuItemCellInterface: class {
    var iconImageView: UIImageView { get }
    var titleLabel: UILabel { get }
    var descriptionLabel: UILabel { get }
    var theme: TCBMenuItemStyle  { get }
    var menuItem: TCBMenuItemProtocol?  { get set }
}

public class TCBMenuItemCell: UITableViewCell, TCBMenuItemCellInterface {
    
    public var theme: TCBMenuItemStyle {
        return TCBDefaultMenuItemStyle()
    }
    
    // MARK: - Views
    lazy public var iconImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy public var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = theme.titleFont //UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textColor = theme.titleColor //UIColor.black.withAlphaComponent(0.85)
        
        return label
    }()
    
    lazy public var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = theme.subtitleFont //UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = theme.subtitleColor //UIColor.black.withAlphaComponent(0.6)
        
        return label
    }()
    
    public var menuItem: TCBMenuItemProtocol? {
        didSet {
            guard let option = menuItem else { return }
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

extension TCBMenuItemCell {
    
    func setupLayout() {
//        selectionStyle = .none
//
//        contentView.addSubview(iconImageView)
//        iconImageView.snp.makeConstraints { (make) in
//            make.width.height.equalTo(48)
//            make.leading.equalToSuperview().inset(16)
//            make.centerY.equalToSuperview()
//        }
//
//        contentView.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { (make) in
//            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
//            make.top.equalTo(iconImageView.snp.top)
//            make.trailing.equalToSuperview()
//        }
//
//        contentView.addSubview(descriptionLabel)
//        descriptionLabel.snp.makeConstraints { (make) in
//            make.leading.equalTo(titleLabel.snp.leading)
//            make.top.equalTo(titleLabel.snp.bottom).offset(1)
//        }
    }
}
