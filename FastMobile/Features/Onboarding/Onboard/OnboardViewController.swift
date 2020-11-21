//
//  OnboardViewController.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 10/30/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import TCBComponents
import TCBService

extension Notification.Name {
    static let didTapCreateAccount = Notification.Name("didTapCreateAccount")
}

final class OnboardViewController: CustomBarViewController {
    
    private let viewModel: OnboardViewModel
    
    private lazy var cardSlider: TCBCardSlider = {
        let slider = TCBCardSlider(frame: .zero)
        slider.clipsToBounds = true
        slider.viewBuilder = self
        slider.setTint(color: .buttonBackground)
        
        let size = view.bounds
        slider.setItemSize(size: CGSize(width: size.width,
                                        height: size.height - 168),
                           style: .centered)
        
        return slider
    }()
    
    private lazy var loginButton: TCBButton = {
        let button = TCBButton()
        button.setTitle("Log in", for: .normal)
        button.foregroundColor = .white
        button.titleFont = .boldFont(16)
        button.backgroundColor = .buttonBackground
        button.layer.cornerRadius = 4
        
        return button
    }()
    
    private lazy var registerButton: TCBButton = {
        let button = TCBButton()
        button.setTitle("Get a bank account", for: .normal)
        button.foregroundColor = .grayLink
        button.titleFont = .boldFont(16)
        button.backgroundColor = .clear
        
        return button
    }()
    
    init(viewModel: OnboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = "OnboardViewController"
        
        setupLayout()
        setupBindings()
        setupContents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(!viewModel.navigator.shouldShowNavigationBar,
                                                     animated: true)
    }
}

// MARK: - Setups

extension OnboardViewController {
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).inset(16)
            make.trailing.equalTo(view.snp.trailing).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(57)
            make.height.equalTo(48)
        }
        
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(loginButton.snp.bottom).offset(16)
        }
        
        view.addSubview(cardSlider)
        cardSlider.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(loginButton.snp.top).inset(-45)
        }
    }
    
    private func setupBindings() {
        let input = OnboardViewModel.Input(loginTrigger: loginButton.rx.tap.asDriver(),
                                           registerTrigger: registerButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        output.gotoLogin.drive().disposed(by: disposeBag)
        output.gotoRegister.drive().disposed(by: disposeBag)
    }
    
    private func setupContents() {
        
        let title1 = "Safe, fast & super easy\nmobile transfer."
        let attrTitle1 = title1.addAttributes(["Safe, fast & super easy": [.font: UIFont.boldFont(28),
                                                                           .foregroundColor: UIColor.black],
                                               "mobile transfer.": [.font: UIFont.regularFont(28),
                                                                    .foregroundColor: UIColor.grayTitle]])
        let image1 = UIImage(named: "onboard_1")
        
        let title2 = "Every banking services.\nAnytime. Anywhere."
        let attrTitle2 = title2.addAttributes(["Every banking services.": [.font: UIFont.boldFont(28),
                                                                           .foregroundColor: UIColor.black],
                                               "Anytime. Anywhere.": [.font: UIFont.regularFont(28),
                                                                      .foregroundColor: UIColor.grayTitle]])
        let image2 = UIImage(named: "onboard_2")
        
        let title3 = "The financial foundation\nfor your success."
        let attrTitle3 = title3.addAttributes(["The": [.font: UIFont.regularFont(28),
                                                       .foregroundColor: UIColor.grayTitle],
                                               "financial foundation": [.font: UIFont.boldFont(28),
                                                                        .foregroundColor: UIColor.black],
                                               "for your success.": [.font: UIFont.regularFont(28),
                                                                     .foregroundColor: UIColor.grayTitle]])
        let image3 = UIImage(named: "onboard_3")
        
        cardSlider.collection = [OnboardCardInfo(title: attrTitle1, image: image1),
                                 OnboardCardInfo(title: attrTitle2, image: image2),
                                 OnboardCardInfo(title: attrTitle3, image: image3)]
    }
}

// MARK: TCBCardSliderViewBuilder

extension OnboardViewController: TCBCardSliderViewBuilder {
    
    public func createViewFor(item: TCBCardSliderItem) -> UIView? {
        guard let card = item as? OnboardCardInfo else { return nil }
        
        let view = OnboardCard(title: card.title, image: card.image)
        
        return view
    }
}

// MARK: OnboardCardInfo

private class OnboardCardInfo: NSObject, TCBCardSliderItem {
    
    let title: NSAttributedString
    let image: UIImage
    
    init(title: NSAttributedString, image: UIImage?) {
        self.title = title
        self.image = image ?? UIImage()
        
        super.init()
    }
}
