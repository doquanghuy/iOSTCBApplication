//
//  DashboardViewController.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/18/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import TCBService
import TCBDomain
import TCBVinPartner
import RxSwift
import TCBComponents

final class DashboardViewController: UIViewController {
    private let user: User?
    private let disposeBag = DisposeBag()
    
    private let scrollView = UIScrollView(frame: .zero)
    private let containerView = UIView()
    
    private lazy var balanceView: BalanceView = {
        let useCase = TCBUseCasesProvider().makeProductUseCase()
        let viewModel = BalanceViewModel(productUseCase: useCase)
        
        return BalanceView(viewModel: viewModel,
                           containerViewController: self,
                           viewWillAppear: rx.sentMessage(#selector(viewWillAppear(_:)))
                            .mapToVoid())
    }()
    
    private lazy var vinPartnerView: TCBVinPartnerView = {
        let viewModel = TCBVinPartnerViewModel()
        
        return TCBVinPartnerView(user: user,
                                 viewModel: viewModel,
                                 viewWillAppear: rx.sentMessage(#selector(viewWillAppear(_:)))
                                    .mapToVoid())
    }()
    
    private lazy var loginButton: TCBButton = {
        let button = TCBButton(state: .active, title: "Log in")
        button.setFontFamily(fontPath: .boldFont(16))
        button.setCornerRadius(radius: 15)
        return button
    }()
    
    init(user: User?) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hello, \(user?.email ?? "User")"
        view.accessibilityIdentifier = "DashboardViewController"
        navigationController?.navigationBar.prefersLargeTitles = true
        additionalSafeAreaInsets.top = 50
        extendedLayoutIncludesOpaqueBars = true
        
        setupLayouts()
        bindViewModels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        title = "Hello, \(user?.email ?? "User")"
        loginButton.isHidden = !(user?.email?.isEmpty ?? true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        containerView.snp.updateConstraints { make in
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(view.bounds.height)
        }
    }
    
    private func setupLayouts() {
        
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        scrollView.contentOffset = .zero
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(scrollView.contentLayoutGuide)
            make.top.equalTo(loginButton.snp.bottom).offset(70)
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(view.bounds.height)
        }
        
        let bgView = UIView(frame: .zero)
        bgView.backgroundColor = .white
        
        containerView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(50)
        }
        
        containerView.addSubview(balanceView)
        balanceView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        containerView.addSubview(vinPartnerView)
        vinPartnerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(balanceView.snp.bottom).offset(16)
        }
    }
    
    private func bindViewModels() {
        vinPartnerView.selectedActionType
            .asDriver()
            .drive(onNext: { [weak self] type in
                self?.didSelectQuickAction(type: type)
            }).disposed(by: disposeBag)
        
        loginButton.rx.tap.asDriver().drive(onNext: {
            // TODO: show login screen
        }).disposed(by: disposeBag)
        
    }
    
    private func didSelectQuickAction(type: TCBQuickActionModel.ActionType) {
        // TODO: handle when selecting an action
    }
}

extension DashboardViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let nav = navigationController as? LargeBarNavigationViewController else { return }
        nav.scrollViewDidScroll(scrollView)
    }
}
