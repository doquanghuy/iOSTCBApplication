//
//  QPLoginViewController.swift
//  TCBPay
//
//  Created by Duong Dinh on 7/29/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import TCBComponents

class LoginViewController: CustomBarViewController {
    
    // MARK: - Views
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.backgroundColor = .appColor
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    /// Container view
    lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .appColor
        
        return view
    }()
    
    /// Email text field
    lazy var passwordTextField: TCBTextField = {
        let textField = TCBTextField()
        
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.inactiveLineColor = .lightGray
        textField.activeLineColor = .lightGray
        textField.activePlaceholderTextColor = .gray
        textField.inactivePlaceholderTextColor = .gray
        textField.errorLineColor = .red
        textField.autocapitalizationType = .none
        textField.font = UIFont.boldFont(32)
        textField.placeholderFontActive = UIFont.mediumFont(18)
        textField.placeholderFontInactive = UIFont.boldFont(22)
        
        return textField
    }()
    
    /// Login button
    lazy var loginButton: TCBButton = {
        let button = TCBButton()
        
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.buttonTextFont
        button.setTitleColor(.white, for: .normal)
        button.setState(state: .inactive)
        button.setCornerRadius(radius: 4)
    
        return button
    }()
    
    lazy var havingTroubleButton: TCBButton = {
        let button = TCBButton()
        
        button.setTitle("Having trouble?", for: .normal)
        button.titleLabel?.font = .buttonTextFont
        button.setTitleColor(UIColor(hexString: "7b7b7b"), for: .normal)
        button.backgroundColor = .clear
        
        return button
    }()
    
    // MARK: - Properties
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Life Cycle
extension LoginViewController {
    
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    override func viewDidLoad() {
        title = "Log in"
        super.viewDidLoad()
        setupBinding()
        
        // TODO: - Temp to retrive profile
        viewModel.getProfile()
        view.accessibilityIdentifier = "LoginViewController"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        passwordTextField.becomeFirstResponder()
    }
}

// MARK: - Setup
extension LoginViewController {
    
    private func setupBinding() {
        let input = LoginViewModel.Input(passwordTrigger: passwordTextField.rx.text.orEmpty.asDriver(),
                                         signInTrigger: loginButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.loginSuccess.drive().disposed(by: disposeBag)
        output.signInEnabled.drive(onNext: { isEnabled in
            self.loginButton.setState(state: isEnabled ? .active : .inactive)
        }).disposed(by: disposeBag)
        output.isLoggingIn.drive(onNext: { isLoggingIn in
            self.loginButton.setState(state: isLoggingIn ? .loading : .active)
        }).disposed(by: disposeBag)
    }
    
    private func setupViews() {
        enableTapToDismissKeyboard()
        
        view.backgroundColor = .appColor
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(containerView)
        let screenWidth = UIScreen.main.bounds.width
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(screenWidth)
        }
        
        containerView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth - 60)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(containerView.snp.top).inset(131)
        }
        
        containerView.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(343)
            make.height.equalTo(48)
            make.top.equalTo(passwordTextField.snp.bottom).offset(105)
            make.bottom.greaterThanOrEqualToSuperview().inset(100)
        }
        
        containerView.addSubview(havingTroubleButton)
        havingTroubleButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.height.equalTo(24)
            make.centerX.equalToSuperview()
        }
    }
}
