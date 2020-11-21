//
//  SecretView.swift
//  FastMobile
//
//  Created by Son le on 10/14/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit

public class SecretView: UIView {
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 22.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var toggleButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(onToggleAction), for: .touchUpInside)
        button.setImage(UIImage(named: "visible"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var content: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configSubViews()
    }

    private func configSubViews() {
        addSubview(contentLabel)
        addSubview(toggleButton)

        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentLabel.topAnchor.constraint(equalTo: topAnchor)
        ])

        let buttonSize: CGFloat = 40
        NSLayoutConstraint.activate([
            toggleButton.widthAnchor.constraint(equalToConstant: buttonSize),
            toggleButton.heightAnchor.constraint(equalToConstant: buttonSize),
            toggleButton.leadingAnchor.constraint(equalTo: contentLabel.trailingAnchor, constant: 5),
            toggleButton.centerYAnchor.constraint(equalTo: contentLabel.centerYAnchor),
            toggleButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc private func onToggleAction() {
        toggleButton.isSelected.toggle()

        guard let text = contentLabel.text, !text.isEmpty else {
            return
        }
        if toggleButton.isSelected {
            let totalChars = max(16, text.count)
            contentLabel.text = String(repeating: "•", count: totalChars)
        } else {
            contentLabel.text = content
        }
    }
}

extension SecretView {
    public func bind(_ content: String?) {
        self.content = content

        if let _content = content, !_content.isEmpty {
            contentLabel.text = content
        } else {
            contentLabel.text = "-"
        }

        toggleButton.isHidden = content?.isEmpty ?? true
    }
}
