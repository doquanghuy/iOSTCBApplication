//
//  TransferOptionsViewControllerTests.swift
//  FastMobileTests
//
//  Created by Dinh Duong on 9/21/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import XCTest
@testable import FastMobile

class TransferOptionsViewControllerTests: XCTestCase {
    var sut: TransferOptionsViewController!
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewControllerNoData() {
        let viewModel = MockTransferOptionsViewModel(options: [])
        sut = TransferOptionsViewController(viewModel: viewModel)
        _ = sut.view
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func testViewControllerWithData() {
        let transferOption1 = TransferOption(iconName: "", title: "", detail: "")
        let transferOption2 = TransferOption(iconName: "", title: "", detail: "")
        let viewModel = MockTransferOptionsViewModel(options: [transferOption1, transferOption2])
        sut = TransferOptionsViewController(viewModel: viewModel)
        _ = sut.view
        sut.tableView.reloadData()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
    }
}
