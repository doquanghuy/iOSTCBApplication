//
//  BankTableViewCell.swift
//  FastMobile
//
//  Created by Thuy Truong Quang on 9/25/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import Domain

class BankTableViewCell: UITableViewCell {

    @IBOutlet weak var logoBankView: UIView! {
        didSet {
            self.logoBankView.layer.cornerRadius = 8
            self.logoBankView.layer.borderWidth = 1
            self.logoBankView.layer.borderColor = UIColor(white: 0.0, alpha: 0.04).cgColor
        }
    }
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var bankDescriptionLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView! {
        didSet {
            checkImageView.isHidden = true
        }
    }
    
    func configCell(item: Bank) {
        self.logoImageView.image = UIImage(named: item.logo)
        self.bankNameLabel.text = item.name
        self.bankDescriptionLabel.text = item.description
    }
    
    override func prepareForReuse() {
        self.logoImageView.image = nil
        self.bankNameLabel.text = nil
        self.bankDescriptionLabel.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        checkImageView.isHidden = !selected
    }
    
}
