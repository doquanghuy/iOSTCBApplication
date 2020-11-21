//
//  FaceIDViewController.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/1/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class FaceIDViewController: NiblessViewController {
    
    private let viewModel: FaceIDViewModel
    
    init(viewModel: FaceIDViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    private lazy var enableButton: TCBButton = {
        let button = TCBButton()
        button.setTitle("Enable Face ID", for: .normal)
        button.foregroundColor = .white
        button.titleFont = .boldFont(16)
        button.backgroundColor = .buttonBackground
        button.layer.cornerRadius = 4
        
        return button
    }()
    
    private lazy var skipButton: TCBButton = {
        let button = TCBButton()
        button.setTitle("Maybe later", for: .normal)
        button.foregroundColor = .grayLink
        button.titleFont = .boldFont(16)
        button.backgroundColor = .clear
        
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "close"), for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = "FaceIDViewController"
        
        setupLayout()
        setupBindings()
    }
}

// MARK: - Setups

extension FaceIDViewController {
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(25)
            make.leading.equalTo(view.snp.leading).inset(21)
        }
        
        view.addSubview(enableButton)
        enableButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).inset(16)
            make.trailing.equalTo(view.snp.trailing).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(57)
            make.height.equalTo(48)
        }
        
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(enableButton.snp.bottom).offset(16)
        }
        
        // faceID logo
        let imageView = UIImageView(image: UIImage(named: "ic_faceID"))
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(189)
        }
        
        // title
        let title = UILabel(frame: .zero)
        title.text = "Enable Face ID"
        title.font = .boldFont(28)
        title.textColor = .blackButtonBackground
        title.textAlignment = .center
        
        view.addSubview(title)
        title.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(34)
        }
        
        let description = UILabel(frame: .zero)
        description.text = "Log in using Face ID instead of your password for easy account access"
        description.font = .regularFont(15)
        description.textColor = .grayLink
        description.textAlignment = .center
        description.numberOfLines = 0
        
        view.addSubview(description)
        description.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).inset(44)
            make.trailing.equalTo(view.snp.trailing).inset(44)
            make.top.equalTo(title.snp.bottom).offset(8)
        }
    }
    
    private func setupBindings() {
        let input = FaceIDViewModel
            .Input(enableTrigger: enableButton.rx.tap.asDriver(),
                   skipTrigger: skipButton.rx.tap.asDriver(),
                   closeTrigger: closeButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        output.enableFaceID.drive().disposed(by: disposeBag)
        output.skipFaceID.drive().disposed(by: disposeBag)
        output.closeFaceID.drive().disposed(by: disposeBag)
    }
}
