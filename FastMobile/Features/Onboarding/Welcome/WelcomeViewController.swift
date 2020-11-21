//
//  WelcomeViewController.swift
//  TCBPay
//
//  Created by Dinh Duong on 9/11/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import UIKit
import Domain
import TCBService

class WelcomeViewController: NiblessViewController {
    private lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = UIActivityIndicatorView.Style.medium
        view.startAnimating()
        return view
    }()

    private lazy var contentView: WelcomeView = {
        let view = WelcomeView(viewModel: viewModel)
        view.alpha = 0
        return view
    }()

    private let viewModel: WelcomeViewModel
    private let client = TCBValidateTokenClient()
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}

// MARK: - Life cycle
extension WelcomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.accessibilityIdentifier = "WelcomeViewController"

        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.height.width.centerX.centerY.equalToSuperview()
        }

        view.addSubview(indicator)
        indicator.snp.makeConstraints { (make) in
            make.height.width.equalTo(50)
            make.center.equalToSuperview()
        }
        
        viewModel.adminLogin()

        client.getValidation { [weak self] _ in
            DispatchQueue.main.async {
//                if let user = user {
//                    self?.viewModel.navigator.goHome(user: user)
//                } else {
                    self?.indicator.stopAnimating()
                    self?.contentView.alpha = 1
//                }
            }
        }
    }
}
