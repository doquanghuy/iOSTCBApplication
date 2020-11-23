//
//  BalanceView.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/18/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import TCBComponents
import SnapKit
import RxSwift
import TCBService
import RxCocoa
import TCBDomain

final class BalanceView: UIView {
    
    private let disposeBag = DisposeBag()
    private var viewModel: BalanceViewModel!
    private weak var containerViewController: UIViewController?
    private var viewWillAppear: Observable<Void> = .never()
    
    private lazy var accountPanel: TCBAccountPanel = {
        let panel = TCBAccountPanel(viewModel: nil)
        return panel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    convenience init(viewModel: BalanceViewModel,
                     containerViewController: UIViewController?,
                     viewWillAppear: Observable<Void>) {
        self.init(frame: .zero)
        self.viewModel = viewModel
        self.containerViewController = containerViewController
        self.viewWillAppear = viewWillAppear
        
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        viewModel.loadProducts()
    }
    
    private func setupLayouts() {
        backgroundColor = .clear
        
        addSubview(accountPanel)
        accountPanel.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        
        viewModel.products
            .asDriver()
            .drive(onNext: { [unowned self] products in
                let account = products.first
                let viewModel = TCBAccountViewModel(title: "Số dư hiện tại",
                                                    id: account?.id,
                                                    name: account?.name,
                                                    balance: account?.amount ?? 0.0,
                                                    description: account?.accountNumber,
                                                    icon: UIImage(named: "ic_ac_type_current"))
                self.accountPanel.viewModel = viewModel
            })
            .disposed(by: disposeBag)
        
        accountPanel.tapAction.rx.event.asDriver().flatMapLatest { _ in
            self.onChangeAccount()
        }.drive(onNext: { account in
            let viewModel = TCBAccountViewModel(title: "Số dư hiện tại",
                                                id: account.id,
                                                name:account.name,
                                                balance: account.balance,
                                                description: account.accountNumber,
                                                icon: UIImage(named: "ic_ac_type_current"))
            self.accountPanel.viewModel = viewModel
        }).disposed(by: disposeBag)
        
        viewWillAppear.bind(onNext: { [weak self] in
            self?.viewModel.loadProducts()
        }).disposed(by: disposeBag)
    }
    
    private func onChangeAccount() -> Driver<Account> {
        let useCase = TCBUseCasesProvider().makeProductUseCase()
        let accountOptionsViewModel = SelectAccountOptionViewModel(productUseCase: useCase)
        let accountOptionsViewController = AccountOptionsViewController(viewModel: accountOptionsViewModel)
        accountOptionsViewController.prepareToPresentAsPanel()
        containerViewController?.present(accountOptionsViewController, animated: true)

        return accountOptionsViewModel.selectedAccountOption.map { accountOption in
            return
                Account(
                    id: accountOption.id,
                    accountNumber: accountOption.accountNumber ,
                    name: accountOption.type.name ?? accountOption.name ?? "",
                    balance: accountOption.amount,
                    type: accountOption.type.rawValue)
        }.asDriverOnErrorJustComplete()
    }
}
