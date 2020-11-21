//
//  SetupPasscodeViewController.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/2/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import TCBComponents

final class SetupPasscodeViewController: NiblessViewController {
    
    private let viewModel: SetupPasscodeViewModel
    
    private lazy var passcodeView: TCBPasscodeView = {
        let view = TCBPasscodeView(numberOfDigits: 4,
                                   emptyColor: .grayLink,
                                   checkedColor: .blackButtonBackground)
        return view
    }()
    
    init(viewModel: SetupPasscodeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = "PasscodeViewController"
        
        setupLayout()
        setupBindings()
    }
}

// MARK: - Setups

extension SetupPasscodeViewController {
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        let title = UILabel(frame: .zero)
        title.font = .boldFont(28)
        title.textAlignment = .center
        title.textColor = .blackButtonBackground
        title.text = "Enter Passcode"

        let description = UILabel(frame: .zero)
        description.font = .regularFont(15)
        description.textAlignment = .center
        description.textColor = .grayLink
        description.numberOfLines = 0
        description.text = "Enter a 4-digit code to use for logging in your banking app"

        view.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(70)
            make.leading.equalTo(view.snp.leading).inset(20)
            make.trailing.equalTo(view.snp.trailing).inset(20)
        }

        view.addSubview(description)
        description.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(8)
            make.leading.equalTo(view.snp.leading).inset(44)
            make.trailing.equalTo(view.snp.trailing).inset(44)
        }
        
        view.addSubview(passcodeView)
        passcodeView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(45)
            make.leading.equalTo(view.snp.leading).inset(44)
            make.trailing.equalTo(view.snp.trailing).inset(44)
            make.height.equalTo(60)
        }
    }
    
    private func setupBindings() {
        
    }
}
