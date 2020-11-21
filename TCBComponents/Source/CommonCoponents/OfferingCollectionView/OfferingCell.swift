//
//  OfferingCell.swift
//  FastMobile
//
//  Created by Son le on 10/15/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit

class OfferingCell: UICollectionViewCell {
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16.0
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var boundLogoImage: UIView = {
        let view = UIView()
        view.addSubview(logoImage)
        view.layer.cornerRadius = 20.0
        view.layer.masksToBounds = false
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configSubViews()
    }

    private func configSubViews() {
        createShadow()
        contentView.backgroundColor = .white
        [backgroundImage, boundLogoImage, titleLabel, subTitleLabel].forEach({ contentView.addSubview($0) })

        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalToConstant: 128)
        ])

        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: boundLogoImage.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: boundLogoImage.centerYAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 27),
            logoImage.heightAnchor.constraint(equalToConstant: 27),

            boundLogoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            boundLogoImage.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -20),
            boundLogoImage.widthAnchor.constraint(equalToConstant: 40),
            boundLogoImage.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            titleLabel.topAnchor.constraint(equalTo: boundLogoImage.bottomAnchor, constant: 2),

            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        ])
    }

    private func createShadow() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16.0)
        contentView.layer.cornerRadius = 16.0
        contentView.layer.masksToBounds = false
        contentView.layer.shadowRadius = 16.0
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowOpacity = 0.08
        contentView.layer.shadowPath = shadowPath.cgPath
    }
}

extension OfferingCell {
    func bind(_ offering: OfferingItem) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 24

        titleLabel.attributedText = NSAttributedString(string: offering.title ?? "",
                                                       attributes: [.paragraphStyle: paragraphStyle])
        subTitleLabel.text = offering.subtitle

//        logoImage.image = offering.logo
//        backgroundImage.image = offering.backgroundImage
        
        if #available(iOS 13.0, *) {
            logoImage.image = UIImage(named: "starbucks_logo", in: Bundle.main, with: nil)
            backgroundImage.image = UIImage(named: "starbucks_drink", in: Bundle.main, with: nil)
        } else {
            // Fallback on earlier versions
        }
    }
}
