//
//  TCBMenuCell.swift
//  FastMobile
//
//  Created by Son le on 11/2/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit
import SnapKit

public class TCBMenuCell: UITableViewCell {

    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configSubViews() {
        contentView.addSubview(iconImage)
        contentView.addSubview(contentLabel)

        iconImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalTo(contentView.snp.leading).offset(32)
        }
        iconImage.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        contentLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView.snp.leading).offset(58)
            make.centerY.equalToSuperview()
        }
    }

    public func bind(icon: String, title: String) {
        if #available(iOS 13.0, *) {
            iconImage.image = UIImage(named: icon, in: .main, with: nil)
        } else {
            iconImage.image = UIImage(named: icon)
        }
        contentLabel.textColor = .blackText
        contentLabel.font = .mediumFont(16)
        contentLabel.text = title
    }

    public func bindSmall(icon: String, title: String) {
        if #available(iOS 13.0, *) {
            iconImage.image = UIImage(named: icon, in: .main, with: nil)
        } else {
            iconImage.image = UIImage(named: icon)
        }
        contentLabel.textColor = .darkGray
        contentLabel.font = .boldFont(14)
        contentLabel.text = title
    }
}
