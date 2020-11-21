//
//  BeneficiaryListViewControllerTests.swift
//  FastMobileTests
//
//  Created by Dinh Duong on 9/22/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import XCTest
@testable import FastMobile

class BeneficiaryListViewControllerTests: XCTestCase {
    var sut: BeneficiaryListViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewControllerNoData() {
        let viewModel = MockBeneficiaryListViewModel(beneficiaries: [], favoriteBeneficiaries: [])
        sut = BeneficiaryListViewController(viewModel: viewModel)
        _ = sut.view
        sut.tableView.reloadData()
        
        XCTAssertEqual(sut.tableView.numberOfSections, 2)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 1), 0)
    }
    
    func testViewControllerWithData() {
        let favoriteBeneficiary = [Beneficiary(accountName: "Favorite", bankName: "TCB", accountId: "111", isFavorited: true, bankIcon: "ic")]
        let fBeneficiary = Beneficiary(accountName: "First", bankName: "TCB", accountId: "111", isFavorited: false, bankIcon: "ic")
        let sBeneficiary = Beneficiary(accountName: "Second", bankName: "TCB", accountId: "111", isFavorited: false, bankIcon: "ic")
        let all = [fBeneficiary, sBeneficiary]
        let viewModel = MockBeneficiaryListViewModel(beneficiaries: all, favoriteBeneficiaries: favoriteBeneficiary)
        sut = BeneficiaryListViewController(viewModel: viewModel)
        _ = sut.view
        sut.tableView.reloadData()
        
        XCTAssertEqual(sut.tableView.numberOfSections, 2)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: BeneficiarySection.favorite.rawValue), favoriteBeneficiary.count)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: BeneficiarySection.all.rawValue), all.count)
        let viewSectionFavorite = sut.tableView.delegate?.tableView?(sut.tableView,
                                                                     viewForHeaderInSection: BeneficiarySection.favorite.rawValue)
        XCTAssertTrue(viewSectionFavorite?.isKind(of: UILabel.self) ?? false)
        XCTAssertEqual((viewSectionFavorite as? UILabel)?.text, "Favorite lists")
        
        let viewSectionAll = sut.tableView.delegate?.tableView?(sut.tableView,
                                                                     viewForHeaderInSection: BeneficiarySection.all.rawValue)
        XCTAssertTrue(viewSectionAll?.isKind(of: UILabel.self) ?? false)
        XCTAssertEqual((viewSectionAll as? UILabel)?.text, "Bank/ Card number accounts")
    }
    
    func testViews() {
        let viewModel = MockBeneficiaryListViewModel(beneficiaries: [], favoriteBeneficiaries: [])
        sut = BeneficiaryListViewController(viewModel: viewModel)
        _ = sut.view
        
        XCTAssertEqual(sut.titleLabel.text, "Beneficiary list")
        XCTAssertEqual(sut.addAccountTitleLabel.text, "New account, card number")
        XCTAssertEqual(sut.searchTextField.placeholder, "  Search by name, account number")
    }
}
