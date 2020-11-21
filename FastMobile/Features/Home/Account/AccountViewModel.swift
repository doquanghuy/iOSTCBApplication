//
//  AccountViewModel.swift
//  FastMobile
//
//  Created by Son le on 10/8/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import TCBService

class AccountViewModel {
    private let disposeBag = DisposeBag()
    private(set) var products = BehaviorRelay<[TCBProductModel]>.init(value: [])
    private let productService: TCBProductService

    init(service: TCBProductService) {
        self.productService = service
    }

    func fetchProducts() {
        productService.fetchProducts { (products, _) in
            Observable.just(products)
                .bind(to: self.products)
                .disposed(by: self.disposeBag)
        }
    }
}
