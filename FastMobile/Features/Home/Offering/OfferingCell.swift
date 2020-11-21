//
//  OfferingCell.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 9/10/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import Domain

class OfferingCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func fillData(with offering: Offering) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 24

        titleLabel.attributedText = NSAttributedString(string: offering.title ?? "", attributes: [.paragraphStyle: paragraphStyle])
        subtitleLabel.text = offering.subtitle
        
        logoImageView.image = UIImage(named: "starbucks_logo")
        backgroundImageView.image = UIImage(named: "starbucks_drink")
//        logoImageView.image = UIImage(named: "starbucks_logo", in: Bundle.main, with: nil)
//        backgroundImageView.image = UIImage(named: "starbucks_drink", in: Bundle.main, with: nil)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16.0)
        layer.masksToBounds = false
        layer.shadowRadius = 16.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.08
        layer.shadowPath = shadowPath.cgPath
    }

}
