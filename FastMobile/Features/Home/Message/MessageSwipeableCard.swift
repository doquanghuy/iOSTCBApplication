//
//  MessageSwipeableCard.swift
//  FastMobile
//
//  Created by duc on 9/12/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import Domain

class MessageSwipeableCard: SwipeableCardViewCard {
    @IBOutlet private weak var backgroundContainerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    /// Shadow View
    private weak var shadowView: UIView?

    /// Inner Margin
    private static let kInnerMargin: CGFloat = 8

    var viewModel: Message? {
        didSet {
            configure(forViewModel: viewModel)
        }
    }

    private func configure(forViewModel viewModel: Message?) {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        iconImageView.image = UIImage(named: viewModel.iconName)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 20
        let attributedString = NSMutableAttributedString(string: viewModel.description + "  " + viewModel.amount, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedString.addAttributes([.font: UIFont(name: "Helvetica Bold", size: 16)!], range: NSRange(location: viewModel.description.count + 2, length: viewModel.amount.count))
        descriptionLabel.attributedText = attributedString
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        configureShadow()
    }

    // MARK: - Shadow

    private func configureShadow() {
        // Shadow View
        self.shadowView?.removeFromSuperview()
        let shadowView = UIView(frame: CGRect(x: MessageSwipeableCard.kInnerMargin,
                                              y: MessageSwipeableCard.kInnerMargin,
                                              width: bounds.width - (2 * MessageSwipeableCard.kInnerMargin),
                                              height: bounds.height - (4 * MessageSwipeableCard.kInnerMargin)))
        insertSubview(shadowView, at: 0)
        self.shadowView = shadowView
        self.applyShadow(width: 0, height: 2)
    }

    private func applyShadow(width: CGFloat, height: CGFloat) {
        if let shadowView = shadowView {
            let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 16.0)
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowRadius = 16.0
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: width, height: height)
            shadowView.layer.shadowOpacity = 0.08
            shadowView.layer.shadowPath = shadowPath.cgPath
        }
    }

}
