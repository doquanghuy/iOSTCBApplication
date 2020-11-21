//
//  TransactionNavigator.swift
//  FastMobile
//
//  Created by duc on 9/21/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import RxSwift
import RxCocoa
import Domain
import TCBService

protocol TransactionNavigator {
    func toSelectSender() -> Driver<Account>
    func toSelectReceiver() -> Driver<Account?>
    func toConfirmation(transaction: Transaction)
    func toHome()
}

class DefaultTransactionNavigator: TransactionNavigator {
    private let navigationController: UINavigationController
    private let disposeBag = DisposeBag()
    private var beneficiaryListViewController: BeneficiaryListViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func toSelectSender() -> Driver<Account> {
        let useCase = TCBUseCasesProvider().makeProductUseCase()
        let accountOptionsViewModel = SelectAccountOptionViewModel(productUseCase: useCase)
        let accountOptionsViewController = AccountOptionsViewController(viewModel: accountOptionsViewModel)
        accountOptionsViewController.prepareToPresentAsPanel()
        navigationController.present(accountOptionsViewController, animated: true)

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

    func toSelectReceiver() -> Driver<Account?> {
        let beneficiaryViewModel = BeneficiaryListViewModel()
        beneficiaryListViewController = BeneficiaryListViewController(viewModel: beneficiaryViewModel)
        guard let vc = beneficiaryListViewController else {
            return Driver.empty()
        }
        let nextNavigationController = BaseNavigationViewController(rootViewController: vc)
        navigationController.present(nextNavigationController, animated: true)
        return beneficiaryViewModel.selectedBeneficiary.map { beneficiary in
            let bank = Bank(name: beneficiary.bankName,
                            logo: beneficiary.bankIcon,
                            description: "",
                            code: "111000025",
                            bic: "INGBNL2A",
                            address: "FINANCIAL PLAZA BIJLMERDREEF 109 1102 BW AMSTERDAM",
                            country: "NL")
            return
                Account(
                    id: "",
                    accountNumber: beneficiary.accountId,
                    name: beneficiary.accountName,
                    nickname: "",
                    balance: 20000000,
                    bank: bank
            )
        }.asDriverOnErrorJustComplete()
    }

    func toConfirmation(transaction: Transaction) {
        var trans = transaction
        
        if trans.amount > trans.sender.balance {
            trans.amount = trans.sender.balance
        }
        
        let confirmationViewController = ConfirmationViewController(nibName: "ConfirmationViewController", bundle: nil)
        let useCase = ConfirmationUseCaseProvider()
        confirmationViewController.viewModel = ConfirmationViewModel(transaction: trans, useCase: useCase, navigator: DefaultConfirmationNavigator(services: useCase, navigationController: navigationController))
        navigationController.pushViewController(confirmationViewController, animated: true)
        confirmationViewController.viewModel.selectedBeneficiaryValue = beneficiaryListViewController?.viewModel.selectedBeneficiaryValue
    }

    func toHome() {
        navigationController.popViewController(animated: true)
    }
}
