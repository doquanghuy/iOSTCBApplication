//
//  AccountOptionsViewModelTests.swift
//  FastMobileTests
//
//  Created by Dinh Duong on 9/22/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import XCTest
@testable import FastMobile

class AccountOptionsViewModelTests: XCTestCase {
    var sut: AccountOptionsViewModel!
    
    override func setUpWithError() throws {
        sut = AccountOptionsViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewModelData() {
        let another = AccountOption(type: "Tài khoản thanh toán", id: "TKTT-1900123456789", amount: "20,000,000 đ")
        let toMe = AccountOption(type: "Tài khoản mobile", id: "0912345678", amount: "50,000 đ")
        let toStockAccount = AccountOption(type: "Tài khoản thấu chi", id: "TC-1900333444", amount: "100,000,000 đ")
        
        XCTAssertEqual(sut.accountOptions.count, 3)
        XCTAssertEqual(sut.accountOptions.first, another)
        XCTAssertEqual(sut.accountOptions[1], toMe)
        XCTAssertEqual(sut.accountOptions.last, toStockAccount)
    }
}
