//
//  BeneficiaryListViewModelTests.swift
//  FastMobileTests
//
//  Created by Dinh Duong on 9/22/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import XCTest
@testable import FastMobile

class BeneficiaryListViewModelTests: XCTestCase {
    var sut: BeneficiaryListViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = BeneficiaryListViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModelData() {
        let fBeneficiary = Beneficiary(accountName: "Vũ Minh Hải", bankName: "Techcombank", accountId: "19021234567899", isFavorited: true, bankIcon: "group")
        let sBeneficiary = Beneficiary(accountName: "Trần Thị Huyền Anh", bankName: "Techcombank", accountId: "19111234567899", isFavorited: true, bankIcon: "group")
        let tBeneficiary = Beneficiary(accountName: "Nguyễn Thu Trang", bankName: "Vietcombank", accountId: "19131234567899", isFavorited: true, bankIcon: "ic_vietcombank")
        let favoriteBeneficiaries = [fBeneficiary, sBeneficiary, tBeneficiary]
        
        let foBeneficiary = Beneficiary(accountName: "Nguyễn Thu Huyền", bankName: "Vietcombank", accountId: "19131234567809", isFavorited: false, bankIcon: "ic_vietcombank")
        let kBeneficiary = Beneficiary(accountName: "Trần Thị Liên", bankName: "Vietcombank", accountId: "19131234567809", isFavorited: false, bankIcon: "ic_vietcombank")
        
        let eBeneficiary = Beneficiary(accountName: "Trần Thu Trang", bankName: "Techcombank", accountId: "19131034567809", isFavorited: false, bankIcon: "group")
        
        let beneficiaries = favoriteBeneficiaries + [foBeneficiary, kBeneficiary, eBeneficiary]
        
        XCTAssertEqual(sut.beneficiaries.count, beneficiaries.count)
        XCTAssertEqual(sut.beneficiaries, beneficiaries)
        XCTAssertEqual(sut.favoriteBeneficiaries.count, favoriteBeneficiaries.count)
        XCTAssertEqual(sut.favoriteBeneficiaries, favoriteBeneficiaries)
    }
}
