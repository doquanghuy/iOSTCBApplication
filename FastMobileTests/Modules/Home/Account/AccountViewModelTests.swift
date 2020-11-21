//
//  AccountViewModelTests.swift
//  FastMobileTests
//
//  Created by Son le on 10/12/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import XCTest
import RxSwift
@testable import FastMobile
@testable import TCBService

class AccountViewModelTests: XCTestCase {

    private let disposebag = DisposeBag()
    private var viewModel: AccountViewModel!

    override func setUp() {
        super.setUp()

        viewModel = AccountViewModel(service: ProductServiceMock())
    }

    func test_getProducts() {
        _ = viewModel.products.subscribe { (event) in
            if event.isStopEvent {
                XCTAssertTrue(event.element?.count == 3)
            }
        }

        viewModel.fetchProducts()
    }
}

class ProductServiceMock: TCBProductService {
    func getProducts(_ completion: (([TCBProductModel], Error?) -> Void)?) {
        let models = [
            TCBProductModel(name: "Credit cards", aggregatedBalance: "650$", accounts: [AccountSummaryData(name: "Visa",
                                                                                                           category: "xxxx 4444",
                                                                                                           amount: NSAttributedString(string: "650$"),
                                                                                                           accessory: nil)]),
            TCBProductModel(name: "Saving Accounts", aggregatedBalance: "889$", accounts: [
                AccountSummaryData(name: "Yearly Saving",
                                   category: "006 070 129",
                                   amount: NSAttributedString(string: "100$"),
                                   accessory: nil),
                AccountSummaryData(name: "Saving money on Baby care",
                                   category: "01397790",
                                   amount: NSAttributedString(string: "789$"),
                                   accessory: nil)
            ]),
            TCBProductModel(name: "Current Accounts", aggregatedBalance: "10.000$", accounts: [AccountSummaryData(name: "Bank",
                                                                                                                  category: "Metropolis",
                                                                                                                  amount: NSAttributedString(string: "10.000$"),
                                                                                                                  accessory: nil)])
        ]
        completion?(models, nil)
    }
}
