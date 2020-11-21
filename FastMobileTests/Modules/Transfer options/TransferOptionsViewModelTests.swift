//
//  TransferOptionsViewModelTests.swift
//  FastMobileTests
//
//  Created by Dinh Duong on 9/21/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import XCTest
@testable import FastMobile

class TransferOptionsViewModelTests: XCTestCase {

    var sut: TransferOptionsViewModel!
    
    override func setUpWithError() throws {
        sut = TransferOptionsViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataValues() {
        let first = TransferOption(iconName: "ic_transfer_another", title: "Transfer to another", detail: "The free and fast transfer is prioritized")
        let second = TransferOption(iconName: "ic_transfer_me", title: "Transfer to me", detail: "Between your accounts at Techcombank")
        let last = TransferOption(iconName: "ic_transfer_stock", title: "Transfer to a stock account", detail: "Money will be received  in 3-5 minutes")
        
        XCTAssertEqual(sut.transferOptions.first, first)
        XCTAssertEqual(sut.transferOptions[1], second)
        XCTAssertEqual(sut.transferOptions.last, last)
    }
}
