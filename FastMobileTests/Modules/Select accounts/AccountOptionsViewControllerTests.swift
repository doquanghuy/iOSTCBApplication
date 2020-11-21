//
//  AccountOptionsViewControllerTests.swift
//  FastMobileTests
//
//  Created by Dinh Duong on 9/22/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import XCTest
@testable import FastMobile

class AccountOptionsViewControllerTests: XCTestCase {
    var sut: AccountOptionsViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewControllerNoData() {
        let viewModel = MockAccountOptionsViewModel(options: [])
        sut = AccountOptionsViewController(viewModel: viewModel)
        sut.tableView.reloadData()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func testViewControllerWithData() {
        let another = AccountOption(type: "Tài khoản thanh toán", id: "TKTT-1900123456789", amount: "20,000,000 đ")
        let toMe = AccountOption(type: "Tài khoản mobile", id: "0912345678", amount: "50,000 đ")
        let toStockAccount = AccountOption(type: "Tài khoản thấu chi", id: "TC-1900333444", amount: "100,000,000 đ")
        let viewModel = MockAccountOptionsViewModel(options: [another, toMe, toStockAccount])
        sut = AccountOptionsViewController(viewModel: viewModel)
        sut.tableView.reloadData()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
    }
}
