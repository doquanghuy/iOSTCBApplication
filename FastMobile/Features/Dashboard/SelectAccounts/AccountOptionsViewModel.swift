//
//  TransferOptionsViewModel.swift
//  FastMobile
//
//  Created by Dinh Duong on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import TCBDomain

protocol AccountOptionsViewModeling {
    var title: String { get }
    var productUseCase: TCBDomain.ProductUseCase { get }
    var accountOptions: [AccountOption] { get }
    var selectedCellIndexPath: IndexPath { get set }
    var selectedAccountOption: PublishSubject<AccountOption> { get }
    func didSelectAccountOption(at indexPath: IndexPath)
    func loadProducts(completion: @escaping (Error?) -> Void)
}

class AccountOptionsViewModel: AccountOptionsViewModeling {
    var title: String {
        return "Danh sách tài khoản"
    }
    var selectedCellIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    var selectedAccountOption = PublishSubject<AccountOption>()
    
    var accountOptions: [AccountOption] = []
    
    let productUseCase: TCBDomain.ProductUseCase
    
    init(productUseCase: TCBDomain.ProductUseCase) {
        self.productUseCase = productUseCase
    }
    
    func didSelectAccountOption(at indexPath: IndexPath) {
        selectedAccountOption.onNext(accountOptions[indexPath.row])
        UserDefaults.standard.setValue(indexPath.row, forKey: "Selected")
    }
    
    func loadProducts(completion: @escaping (Error?) -> Void) {
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
                self.accountOptions = accountOptions ?? []
                completion(nil)
            case let .error(error):
                completion(error)
            }
        }
    }
}

class SelectAccountOptionViewModel: AccountOptionsViewModel {
    override var title: String {
        return "Lựa chọn tài khoản"
    }
}
