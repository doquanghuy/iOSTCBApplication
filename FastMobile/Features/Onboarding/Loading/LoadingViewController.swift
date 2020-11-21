//
//  LoadingViewController.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 10/30/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import TCBService
import Domain

final class LoadingViewController: NiblessViewController {
    private let navigator: LoadingNavigator
    
    private let logo = UIImageView(image: UIImage(named: "tcb_logo"))
    private let indicator = UIActivityIndicatorView()
    private let client = TCBValidateTokenClient()
    private let viewModel = LoadingViewModel()
    
    init(navigator: LoadingNavigator) {
        self.navigator = navigator
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = "LoadingViewController"
        setupLayout()
        loadModels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - Setups

extension LoadingViewController {
    
    private func setupLayout() {
        view.backgroundColor = UIColor.redBackground
        
        view.addSubview(logo)
        logo.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(181)
        }
        
        view.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-54)
        }
    }
    
    private func loadModels() {
        indicator.startAnimating()
        
        viewModel.adminLogin {[weak self] result in
            switch result {
            case .success:
                self?.client.getValidation { [weak self] user in
                    DispatchQueue.main.async {
                        self?.indicator.stopAnimating()
                        
                        #if DEBUG
                        self?.goToDebugViewControllers(user)
                        #else
                        if let user = user {
                            self?.navigator.goHome(user: user)
                        } else {
                            self?.navigator.goOnboard()
                        }
                        #endif
                    }
                }
            case .error(let error):
                DispatchQueue.main.async {
                    self?.navigator.goOnboard()
                }
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    #if DEBUG
    private func goToDebugViewControllers(_ user: User?) {
        switch DebugMenu.shared.firstVCType {
        case .dashboard:
            navigator.goHomeWithoutLogin()
        case .default:
            if let user = user {
                navigator.goHome(user: user)
            }
            else {
                navigator.goOnboard()
            }
        default:
            navigator.goTo(viewController: DebugMenu.shared.firstVC)
        }
    }
    #endif
}
