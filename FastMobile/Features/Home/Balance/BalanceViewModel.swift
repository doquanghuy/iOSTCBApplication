//
//  BalanceViewModel.swift
//  FastMobile
//
//  Created by Techcom on 9/11/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import TCBService
import Domain

class BalanceViewModel {
    private let disposeBag = DisposeBag()
    private let productService: TCBProductService
    private(set) var widgetViewModels = BehaviorRelay<[WidgetViewModel]>(value: [])
    private(set) var isBalanceHidden = BehaviorRelay<Bool>(value: false)
    private(set) var balanceLabelText = BehaviorRelay<String?>(value: nil)
    private(set) var balance = BehaviorRelay<String?>(value: nil)
    private(set) var products = BehaviorRelay<[AccountOption]>(value: [])
    
    let productUseCase: Domain.ProductUseCase
    
    init(productService: TCBProductService, productUseCase: Domain.ProductUseCase) {
        self.productService = productService
        self.productUseCase = productUseCase

        isBalanceHidden.subscribe(onNext: { [weak self] _ in
            self?.updateBalanceTextLabel()
        }).disposed(by: disposeBag)
        balance.subscribe(onNext: { [weak self] _ in
            self?.updateBalanceTextLabel()
        }).disposed(by: disposeBag)
    }
    
    func fetchWidgets() {
        MockResponsitory.fetchWidgets()
            .bind(to: widgetViewModels)
            .disposed(by: disposeBag)
    }

    func fetchBalance() {
        productService.fetchBalance { balance, _ in
            if let balance = balance {
                self.balance.accept(balance)
            } else {
                // TODO: Handle
            }
        }
    }
    
    func visibilityButtonTap() {
        isBalanceHidden.accept(!isBalanceHidden.value)
    }

    private func updateBalanceTextLabel() {
        guard var balance = balance.value else {
            return
        }
        if isBalanceHidden.value {
            balance = "●●●●●●●●●●●●●"
        }

        balanceLabelText.accept(balance)
    }
    
    func loadProducts() {
        productUseCase.getProducts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(products):
                let accountOptions = products?.map { product -> AccountOption in
                    return AccountOption(type: AccountType(rawValue: product.type ?? "") ?? .current,
                                         id: product.id ?? "",
                                         accountNumber: product.accountNumber ?? "",
                                         name: product.name,
                                         amount: product.amount ?? 0.0)
                }
                self.products.accept(accountOptions ?? [])
            case .error:
                self.products.accept([])
            }
        }
    }
}
