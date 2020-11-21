//
//  WelcomeView.swift
//  TCBPay
//
//  Created by Dinh Duong on 9/11/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class WelcomeView: NiblessView {
    // MARK: - Views
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Welcome to\n the new \nF@st Mobile"
        label.textColor = .darkGray
        label.font = UIFont.headerFont
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        
        label.text = "New level of features\nwith new app"
        label.textColor = .darkGray
        label.font = UIFont.messageFont
        label.numberOfLines = 0
        
        return label
    }()
    
    /// Login button
    lazy var loginButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.buttonTextFont
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 13
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.darkGray
        
        return button
    }()
    
    /// Signup button
    lazy var signupButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Become a client", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.buttonTextFont
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 13
        button.layer.masksToBounds = true
        button.backgroundColor = .appRedColor
        
        return button
    }()
    
    // MARK: - Properties
    private var hierachyNotReady = true
    private let viewModel: WelcomeViewModel
    private let disposeBag = DisposeBag()
    
    init(frame: CGRect = .zero, viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
}

// MARK: - Life Cycle
extension WelcomeView {
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        guard hierachyNotReady else {
            return
        }
        setupLayout()
        setupBindings()
        hierachyNotReady = false
    }
}

// MARK: - Setups
extension WelcomeView {
    
    private func setupLayout() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(50)
            make.height.equalTo(250)
        }
        
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.height.equalTo(80)
        }
        
        let screenWidth = UIScreen.main.bounds.width
        addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.equalTo(screenWidth - 40)
            make.height.equalTo(70)
            make.top.equalTo(messageLabel.snp.bottom).offset(50)
        }
        
        addSubview(signupButton)
        signupButton.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.equalTo(loginButton.snp.width)
            make.height.equalTo(70)
            make.top.equalTo(loginButton.snp.bottom).offset(20)
        }
    }
    
    private func setupBindings() {
        let input = WelcomeViewModel.Input(signInTrigger: loginButton.rx.tap.asDriver(),
                                           registerTrigger: signupButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        output.gotoSignIn.drive().disposed(by: disposeBag)
        output.gotoRegister.drive().disposed(by: disposeBag)
    }
}
