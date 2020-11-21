//
//  WidgetCell.swift
//  FastMobile
//
//  Created by Techcom on 9/11/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit

class WidgetCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    func bind(_ viewModel: WidgetViewModel) {
        titleLabel.text = viewModel.title
        iconImageView.image = UIImage(named: viewModel.iconName)
    }
}
