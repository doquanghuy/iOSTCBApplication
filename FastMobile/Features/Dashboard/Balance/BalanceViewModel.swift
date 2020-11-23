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
import TCBDomain

class BalanceViewModel {
    
    private(set) var products = BehaviorRelay<[Product]>(value: [])
    
    let productUseCase: TCBDomain.ProductUseCase
    
    init(productUseCase: TCBDomain.ProductUseCase) {
        self.productUseCase = productUseCase
    }
    
    func loadProducts() {
        guard products.value.isEmpty else {
            return
        }
        
        productUseCase.getProducts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(list):
                self.products.accept(list ?? [])
            case .error:
                self.products.accept([])
            }
        }
    }
}
