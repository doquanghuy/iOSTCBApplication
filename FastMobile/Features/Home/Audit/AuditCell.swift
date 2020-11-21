//
//  RecentActivityCell.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/11/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import Domain
import SnapKit

class AuditCell: UITableViewCell {
    static let cellIdentifier = "AuditCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 3
        
        return label
    }()
    
    lazy var timeStampLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        // Font
        selectionStyle = .none
        titleLabel.font = .boldFont(14.0)
        titleLabel.textColor = UIColor(hexString: "262626")
        
        timeStampLabel.font = .regularFont(14.0)
        timeStampLabel.textColor = UIColor(hexString: "9e9e9e")

        descriptionLabel.font = .regularFont(14.0)
        descriptionLabel.textColor = UIColor.black.withAlphaComponent(0.8)
        
        // Constraint
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(timeStampLabel)
        timeStampLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(16)
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(5)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(10)
            make.centerY.equalTo(timeStampLabel.snp.centerY)
            make.trailing.greaterThanOrEqualTo(timeStampLabel.snp.leading).offset(10)
        }
    }
    
    func fillData(with auditMessage: AuditMessage) {
        titleLabel.text = auditMessage.eventDescription
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let timeStamp = auditMessage.timestamp, let date = formatter.date(from: timeStamp) {
            let newFormatter = DateFormatter()
            // initially set the format based on your datepicker date / server String
            newFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let myString = Int(date.timeIntervalSinceNow).toTimeString()
            timeStampLabel.text = myString
        }
        
        descriptionLabel.text = auditMessage.eventCategory
    }
}
