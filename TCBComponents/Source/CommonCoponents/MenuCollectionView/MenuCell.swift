//
//  MenuCVCell.swift
//  FastMobile
//
//  Created by Son le on 10/14/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 12.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var iconMenu: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let boundHeight: CGFloat = 56
    private lazy var boundContent: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.07)
        view.layer.cornerRadius = boundHeight / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        contentView.addSubview(boundContent)
        boundContent.addSubview(iconMenu)
        boundContent.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            boundContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            boundContent.topAnchor.constraint(equalTo: contentView.topAnchor),
            boundContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            boundContent.heightAnchor.constraint(equalToConstant: boundHeight)
        ])

        NSLayoutConstraint.activate([
            iconMenu.centerXAnchor.constraint(equalTo: boundContent.centerXAnchor),
            iconMenu.centerYAnchor.constraint(equalTo: boundContent.centerYAnchor),
            iconMenu.leadingAnchor.constraint(equalTo: boundContent.leadingAnchor),
            iconMenu.topAnchor.constraint(equalTo: boundContent.topAnchor),

            titleLabel.topAnchor.constraint(equalTo: boundContent.bottomAnchor, constant: 4),
            titleLabel.centerXAnchor.constraint(equalTo: boundContent.centerXAnchor),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: boundContent.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension MenuCell {
    func bind(_ icon: String, title: String) {
        iconMenu.image = UIImage(named: icon)
        titleLabel.text = title
    }
}
