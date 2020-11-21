//
//  BalanceViewController.swift
//  FastMobile
//
//  Created by Techcom on 9/10/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SkeletonView
import TCBComponents
import TCBService
import Domain

class BalanceViewController: UIViewController {

    @IBOutlet private weak var secretView: SecretView!
    @IBOutlet private weak var menuCollection: MenuCollectionView!
    @IBOutlet weak var changeAccountButton: UIButton!
    @IBOutlet weak var accountKindLabel: UILabel!
    
    var viewModel: BalanceViewModel!
    private(set) var currentAccount = BehaviorRelay<Account?>(value: nil)
    private let disposeBag = DisposeBag()

    private lazy var accountPanel: TCBAccountPanel = {
        let panel = TCBAccountPanel(viewModel: nil)
        return panel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureSubviews()
        bindViewMode()
        view.accessibilityIdentifier = "BalanceViewController"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadProducts()
    }

    // MARK: Private

    private func configureSubviews() {
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        menuCollection.isSkeletonable = true
        menuCollection.showAnimatedSkeleton()

        secretView.isSkeletonable = true
        secretView.showAnimatedSkeleton()
        secretView.isHidden = true
        accountKindLabel.isHidden = true
        changeAccountButton.isHidden = true
        view.backgroundColor = .clear

        menuCollection.onSelectedIndexPath = { [weak self] indexPath in
            guard let accountModel = self?.accountPanel.viewModel else { return }
            
            let bank = Bank(name: "Techcombank", logo: "group", description: "")
            let account = Account(id: accountModel.id ?? "",
                                  accountNumber: accountModel.description ?? "",
                                  name: accountModel.name ?? "",
                                  balance: accountModel.balance,
                                  bank: bank)
            let transactionViewController = TransactionViewController()
            transactionViewController.viewModel = TransactionViewModel(useCase: DefaultTransactionUseCase(),
                                                                       navigator: DefaultTransactionNavigator(navigationController: (self?.navigationController!)!),
                                                                       senderAccount: account,
                                                                       receiverAccount: nil)
            self?.navigationController?.pushViewController(transactionViewController, animated: true)
//            let vc = TransferOptionsViewController(viewModel: TransferOptionsViewModel())
//            vc.prepareToPresentAsPanel()
//
//            self?.navigationController?.pushViewController(vc, animated: true)
            //            if indexPath.row == 0 {
            //                self?.navigationController?.pushViewController(AccountViewController(), animated: true)
            //                    let vc = TransferOptionsViewController(viewModel: TransferOptionsViewModel())
            //                    vc.prepareToPresentAsPanel()
            //                    self?.navigationController?.present(vc, animated: true)
            //            }
            //            } else if indexPath.row == 1 {
            //                let vc = TransferOptionsViewController(viewModel: TransferOptionsViewModel())
            //                vc.prepareToPresentAsPanel()
            //                self?.navigationController?.present(vc, animated: true)
            //            }
        }
        
        view.addSubview(accountPanel)
        accountPanel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }

    private func bindViewMode() {
        
        NotificationCenter.default.rx.notification(.refeshDataInHomeVC).subscribe { [weak self](notification) in
            self?.viewModel.loadProducts()
        }.disposed(by: disposeBag)
        
        changeAccountButton.rx.tap.bind(onNext: {
            let useCase = TCBUseCasesProvider().makeProductUseCase()
            let accountOptionsViewModel = AccountOptionsViewModel(productUseCase: useCase)
            let accountOptionsViewController = AccountOptionsViewController(viewModel: accountOptionsViewModel)
            accountOptionsViewController.prepareToPresentAsPanel()
            accountOptionsViewController.viewModel.selectedAccountOption.bind(onNext: { accountItem in
                self.viewModel.balance.accept(accountItem.amount.originString)
                self.accountKindLabel.text = accountItem.type.name
            }).disposed(by: self.disposeBag)
            
            self.navigationController?.present(accountOptionsViewController, animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.balanceLabelText
            .asDriver()
            .drive(onNext: { [unowned self] balance in
                if self.secretView.isSkeletonActive {
                    self.secretView.hideSkeleton()
                }
                self.secretView.bind(balance)
            })
            .disposed(by: disposeBag)

        viewModel.widgetViewModels
            .asDriver()
            .drive(onNext: { [unowned self] models in
                let newModels = models.compactMap({ MenuItem(title: $0.title, iconName: $0.iconName) })
                self.menuCollection.bind(newModels)
                if self.menuCollection.isSkeletonActive {
                    self.menuCollection.hideSkeleton()
                }
            }).disposed(by: disposeBag)
        
        viewModel.products
            .asDriver()
            .drive(onNext: { [unowned self] products in
                let account = products.first
                let viewModel = TCBAccountViewModel(title: "Số dư hiện tại",
                                                    id: account?.id,
                                                    name: account?.type.name ?? account?.name,
                                                    balance: account?.amount ?? 0.0,
                                                    description: account?.accountNumber,
                                                    icon: account?.type.icon)
                self.accountPanel.viewModel = viewModel
                self.currentAccount.accept(Account(id: account?.id ?? "",
                                                   accountNumber: account?.accountNumber ?? "",
                                                   name: account?.name ?? "",
                                                   balance: account?.amount ?? 0.0))
            })
            .disposed(by: disposeBag)

        viewModel.fetchWidgets()
        viewModel.fetchBalance()
        viewModel.loadProducts()
        
        accountPanel.tapAction.rx.event.asDriver().flatMapLatest { _ in
            self.onChangeAccount()
        }.drive(onNext: { account in
            let type: AccountType = AccountType(rawValue: account.type ?? "") ?? .current
            let viewModel = TCBAccountViewModel(title: "Số dư hiện tại",
                                                id: account.id,
                                                name:account.name,
                                                balance: account.balance,
                                                description: account.accountNumber,
                                                icon: type.icon)
            self.accountPanel.viewModel = viewModel
            self.currentAccount.accept(account)
        }).disposed(by: disposeBag)

    }
    
    func onChangeAccount() -> Driver<Account> {
        let useCase = TCBUseCasesProvider().makeProductUseCase()
        let accountOptionsViewModel = SelectAccountOptionViewModel(productUseCase: useCase)
        let accountOptionsViewController = AccountOptionsViewController(viewModel: accountOptionsViewModel)
        accountOptionsViewController.prepareToPresentAsPanel()
        navigationController?.present(accountOptionsViewController, animated: true)

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
