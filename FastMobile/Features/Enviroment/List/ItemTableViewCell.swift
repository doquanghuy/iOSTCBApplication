//
//  ItemTableViewCell.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 11/4/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit
import Domain

protocol ItemTableViewCellDelegate: class {
    func editEnviroment(_ enviroment: Environment?)
}

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var enviromentLabel: UILabel!
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var checkmarkImageView: UIImageView!
    
    weak var delegate: ItemTableViewCellDelegate?
    
    var enviroment: Environment? {
        didSet {
            enviromentLabel.text = enviroment?.text
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(_ enviroment: Environment) {
        self.enviroment = enviroment
        if self.enviroment == TCBEnvironmentManager.shared.getEnviroment() {
            checkmarkImageView.isHidden = false
        } else {
            checkmarkImageView.isHidden = true
        }
    }
    
    @IBAction func editAction(_ sender: Any) {
        delegate?.editEnviroment(enviroment)
    }
}
