//
//  TCBAccountPanel.swift
//  Alamofire
//
//  Created by Pham Thanh Hoa on 11/6/20.
//

import Foundation
import UIKit

public class TCBAccountPanel: UIView {
    
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor(to: 22)
        image.widthAnchor(to: 22)
        
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor(to: 20)
        
        return label
    }()
    
    private lazy var accountNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.black.withAlphaComponent(0.85)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor(to: 24)
        
        return label
    }()
    
    private lazy var accountBalanceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.black.withAlphaComponent(0.85)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor(to: 24)
        
        return label
    }()
    
    private lazy var accountDescLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor(to: 20)
        
        return label
    }()
    
    private lazy var indicator = UIActivityIndicatorView()

    public lazy var tapAction = UITapGestureRecognizer(target: self, action: #selector(onChangeAccount))
    
    public var viewModel: TCBAccountViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                indicator.startAnimating()
                return
            }
            
            titleLabel.text = viewModel.title
            accountNameLabel.text = "\(viewModel.balance.formattedNumber ?? "0") đ"
            accountBalanceLabel.text = nil
            accountDescLabel.text = viewModel.name
            icon.image = viewModel.icon
            
            indicator.stopAnimating()
        }
    }
    
    public convenience init(viewModel: TCBAccountViewModel?) {
        self.init(frame: .zero)
        self.viewModel = viewModel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let background = UIView(frame: .zero)
        background.backgroundColor = .white
        background.layer.cornerRadius = 16
        background.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(background)
        background.leadingAnchor(to: leadingAnchor, constant: 16)
        background.trailingAnchor(to: trailingAnchor, constant: -16)
        background.topAnchor(to: topAnchor)
        background.bottomAnchor(to: bottomAnchor)
        background.heightAnchor(to: 97)
        
        background.addSubview(titleLabel)
        titleLabel.leadingAnchor(to: background.leadingAnchor, constant: 24)
        titleLabel.topAnchor(to: background.topAnchor, constant: 16)
        
        background.addSubview(accountNameLabel)
        accountNameLabel.topAnchor(to: titleLabel.bottomAnchor)
        
        background.addSubview(icon)
        icon.leadingAnchor(to: titleLabel.leadingAnchor)
        icon.centerYAnchor(to: accountNameLabel.centerYAnchor)
        icon.trailingAnchor(to: accountNameLabel.leadingAnchor, constant: -8)
        
        background.addSubview(accountDescLabel)
        accountDescLabel.leadingAnchor(to: accountNameLabel.leadingAnchor)
        accountDescLabel.topAnchor(to: accountNameLabel.bottomAnchor)
        
        let balanceView = UIView(frame: .zero)
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        
        background.addSubview(balanceView)
        balanceView.centerYAnchor(to: accountNameLabel.centerYAnchor)
        balanceView.trailingAnchor(to: background.trailingAnchor, constant: -20 )
        
        balanceView.addSubview(accountBalanceLabel)
        accountBalanceLabel.leadingAnchor(to: balanceView.leadingAnchor)
        accountBalanceLabel.topAnchor(to: balanceView.topAnchor)
        accountBalanceLabel.bottomAnchor(to: balanceView.bottomAnchor)
        
        let icon = UIImageView(image: UIImage(named: "ic_arrow_next",
                                              in: Bundle(for: TCBAccountPanel.self),
                                              compatibleWith: nil))
        icon.contentMode = .center
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        balanceView.addSubview(icon)
        icon.trailingAnchor(to: balanceView.trailingAnchor)
        icon.centerYAnchor(to: balanceView.centerYAnchor)
        icon.leadingAnchor(to: accountBalanceLabel.trailingAnchor, constant: 8)
        
        addGestureRecognizer(tapAction)
        
        addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor(to: centerXAnchor)
        indicator.centerYAnchor(to: centerYAnchor)
        
        background.layer.addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onChangeAccount() {
    }
}

extension CALayer {
    
    @discardableResult
    func addShadow() -> CALayer {
        shadowOffset = .zero
        shadowOpacity = 0.1
        shadowRadius = 8
        shadowColor = UIColor.black.cgColor
        masksToBounds = false
        
        return self
    }
}
