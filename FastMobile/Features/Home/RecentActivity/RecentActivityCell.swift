//
//  RecentActivityCell.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/11/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import Domain

class RecentActivityCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        titleLabel.font = .boldFont(14.0)
        titleLabel.textColor = UIColor(hexString: "262626")

        categoryLabel.font = .regularFont(14.0)
        categoryLabel.textColor = UIColor(hexString: "9e9e9e")
    }

    func fillData(with recentActivity: Domain.TransactionItem) {
        if let amount = recentActivity.amount {
            let prefix = amount < 0 ? "" : "+"
            let numberAttribute = NSAttributedString(string: "\(prefix)\(amount.formattedNumber ?? "-")",
                                                     attributes: [NSAttributedString.Key.font: UIFont.boldFont(13.0)])
            let currencyAttribute = NSAttributedString(string: " \(recentActivity.currency)",
                                                       attributes: [NSAttributedString.Key.font: UIFont.boldFont(13.0), NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            let result = NSMutableAttributedString()
            result.append(numberAttribute)
            result.append(currencyAttribute)

            amountLabel.attributedText = result
        } else {
            amountLabel.text = "..."
        }

        let name = recentActivity.receiverName != nil ? recentActivity.receiverName : "Transaction"
        let desc = recentActivity.description

//        let result = NSMutableAttributedString()
//        if let _name = name {
//            let nameAttribute = NSAttributedString(string: "\(_name)",
//                                                   attributes: [NSAttributedString.Key.font: UIFont.boldFont(14.0),
//                                                                NSAttributedString.Key.foregroundColor : UIColor.black])
//            result.append(nameAttribute)
//        }
//
//        if let _desc = desc, _desc != "" {
//            let descAttribute = NSAttributedString(string: "\n\(_desc)",
//                                                   attributes: [NSAttributedString.Key.font: UIFont.boldFont(14.0),
//                                                                NSAttributedString.Key.foregroundColor : UIColor(hexString: "9e9e9e")])
//            result.append(descAttribute)
//        }
//        titleLabel.attributedText = result
        titleLabel.text = name
        categoryLabel.text = desc
    }
}
