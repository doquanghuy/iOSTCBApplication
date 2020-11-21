//
//  RegisterViewController.swift
//  FastMobile
//
//  Created by Duong Dinh on 10/29/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit
import TCBComponents

class RegisterViewController: CustomBarViewController {
    
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
    lazy var userNameTextField: TCBTextField = {
        let textField = TCBTextField()
        
        textField.placeholder = "Username"
        textField.inactiveLineColor = .lightGray
        textField.activeLineColor = .lightGray
        textField.activePlaceholderTextColor = .gray
        textField.inactivePlaceholderTextColor = .gray
        textField.errorLineColor = .red
        textField.autocapitalizationType = .none
        textField.font = UIFont.boldFont(20)
        textField.placeholderFontActive = UIFont.mediumFont(12)
        textField.placeholderFontInactive = UIFont.boldFont(18)
        textField.text = viewModel.prefilledUsername
        
        return textField
    }()
    
    /// Email text field
    lazy var firstNameTextField: TCBTextField = {
        let textField = TCBTextField()
        
        textField.placeholder = "First name"
        textField.inactiveLineColor = .lightGray
        textField.activeLineColor = .lightGray
        textField.activePlaceholderTextColor = .gray
        textField.inactivePlaceholderTextColor = .gray
        textField.errorLineColor = .red
        textField.autocapitalizationType = .none
        textField.font = UIFont.boldFont(20)
        textField.placeholderFontActive = UIFont.mediumFont(12)
        textField.placeholderFontInactive = UIFont.boldFont(18)
        
        return textField
    }()
    
    /// Email text field
    lazy var lastNameTextField: TCBTextField = {
        let textField = TCBTextField()
        
        textField.placeholder = "Last name"
        textField.inactiveLineColor = .lightGray
        textField.activeLineColor = .lightGray
        textField.activePlaceholderTextColor = .gray
        textField.inactivePlaceholderTextColor = .gray
        textField.errorLineColor = .red
        textField.autocapitalizationType = .none
        textField.font = UIFont.boldFont(20)
        textField.placeholderFontActive = UIFont.mediumFont(12)
        textField.placeholderFontInactive = UIFont.boldFont(18)
        
        return textField
    }()
    
    /// Email text field
    lazy var emailTextField: TCBTextField = {
        let textField = TCBTextField()
        
        textField.placeholder = "Email"
        textField.inactiveLineColor = .lightGray
        textField.activeLineColor = .lightGray
        textField.activePlaceholderTextColor = .gray
        textField.inactivePlaceholderTextColor = .gray
        textField.errorLineColor = .red
        textField.autocapitalizationType = .none
        textField.font = UIFont.boldFont(20)
        textField.placeholderFontActive = UIFont.mediumFont(12)
        textField.placeholderFontInactive = UIFont.boldFont(18)
        
        return textField
    }()
    
    /// Password text field
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
        textField.font = UIFont.boldFont(20)
        textField.placeholderFontActive = UIFont.mediumFont(12)
        textField.placeholderFontInactive = UIFont.boldFont(18)
        
        return textField
    }()
    
    /// Register button
    lazy var registerButton: TCBButton = {
        let button = TCBButton()
        
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.buttonTextFont
        button.setTitleColor(.white, for: .normal)
        button.setState(state: .inactive)
        button.setCornerRadius(radius: 4)
    
        return button
    }()
    
    var viewModel: RegisterViewModel
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Life Cycle
extension RegisterViewController {
    
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    override func viewDidLoad() {
        title = "Register"
        super.viewDidLoad()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userNameTextField.becomeFirstResponder()
    }
}

// MARK: - Setup
extension RegisterViewController {
    
    private func setupBinding() {
        let input = RegisterViewModel.Input(emailTrigger: emailTextField.rx.text.orEmpty.asDriver(),
                                            passwordTrigger: passwordTextField.rx.text.orEmpty.asDriver(),
                                            usernameTrigger: userNameTextField.rx.text.orEmpty.asDriver(),
                                            firstNameTrigger: firstNameTextField.rx.text.orEmpty.asDriver(),
                                            lastNameTrigger: lastNameTextField.rx.text.orEmpty.asDriver(),
                                            registerTrigger: registerButton.rx.tap.asDriver())

        let output = viewModel.transform(input: input)

        output.registerSuccess.drive(onNext: { _ in
            self.registerButton.setState(state: .active)
        })
        .disposed(by: disposeBag)
        
        output.registerEnabled.drive(onNext: { isEnabled in
            self.registerButton.setState(state: isEnabled ? .active : .inactive)
        }).disposed(by: disposeBag)
        
        output.isRegisteringIn.drive(onNext: { isRegistering in
            self.registerButton.setState(state: isRegistering ? .loading : .active)
        }).disposed(by: disposeBag)
        
        registerButton.setState(state: .inactive)
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
        
        containerView.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth - 40)
            make.height.equalTo(100)
            make.leading.equalTo(16)
            make.top.equalTo(containerView.snp.top).inset(20)
        }
        
        containerView.addSubview(firstNameTextField)
        firstNameTextField.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth - 40)
            make.height.equalTo(100)
            make.leading.equalTo(16)
            make.top.equalTo(userNameTextField.snp.bottom).offset(2)
        }
        
        containerView.addSubview(lastNameTextField)
        lastNameTextField.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth - 40)
            make.height.equalTo(100)
            make.leading.equalTo(16)
            make.top.equalTo(firstNameTextField.snp.bottom).offset(2)
        }
        
        containerView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth - 40)
            make.height.equalTo(100)
            make.leading.equalTo(16)
            make.top.equalTo(lastNameTextField.snp.bottom).offset(2)
        }
        
        containerView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth - 40)
            make.height.equalTo(50)
            make.leading.equalTo(emailTextField.snp.leading)
            make.top.equalTo(emailTextField.snp.bottom).offset(2)
        }
        
        containerView.addSubview(registerButton)
        registerButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.top.equalTo(passwordTextField.snp.bottom).offset(105)
            make.bottom.greaterThanOrEqualToSuperview().inset(100)
        }
    }
}
