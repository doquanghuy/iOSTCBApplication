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
import Domain
import TCBVinPartner
import RxSwift

final class DashboardViewController: UIViewController {
    private let user: User?
    private let disposeBag = DisposeBag()
    
    private let scrollView = UIScrollView(frame: .zero)
    
    private lazy var balanceView: BalanceView = {
        let useCase = TCBUseCasesProvider().makeProductUseCase()
        let viewModel = BalanceViewModel(productUseCase: useCase)
        
        return BalanceView(viewModel: viewModel,
                           containerViewController: self)
    }()
    
    private lazy var vinPartnerView: TCBVinPartnerView = {
        let viewModel = TCBVinPartnerViewModel()
        
        return TCBVinPartnerView(user: user, viewModel: viewModel)
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
        
        title = "Hello, \(user?.email ?? "")"
        view.accessibilityIdentifier = "DashboardViewController"
        navigationController?.navigationBar.prefersLargeTitles = true
        additionalSafeAreaInsets.top = 432 - 64 - 76
        
        setupLayouts()
        bindViewModels()
    }
    
    private func setupLayouts() {
        scrollView.delegate = self
        view.addSubview(scrollView)

        scrollView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(-150)
        }

        let containerView = UIView()

        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(view.bounds.height)
        }
        
        let bgView = UIView(frame: .zero)
        bgView.backgroundColor = .white
        
        containerView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(48)
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
