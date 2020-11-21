//
//  TCBPasscodeViewModelTests.swift
//  FastMobileTests
//
//  Created by Duong Dinh on 10/8/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import XCTest
@testable import FastMobile

class TCBPasscodeViewModelTests: XCTestCase {
    var sut: TCBPasscodeViewModel!
    
    override func setUpWithError() throws {
        sut = TCBPasscodeViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

extension TCBPasscodeViewModelTests {
    
    func testNumberOfPads() {
        let expectValue = 12
        let result = sut.numberOfPads
        
        XCTAssertEqual(expectValue, result)
    }
    
    func testShouldHideCell() {
        let hideIndex1 = 9
        let hideIndex2 = 11
        let shouldHide1 = sut.shouldHideCellAt(index: hideIndex1)
        let shouldHide2 = sut.shouldHideCellAt(index: hideIndex2)
        
        XCTAssertTrue(shouldHide1)
        XCTAssertTrue(shouldHide2)
        
        let noHideIndex = 0
        let result = sut.shouldHideCellAt(index: noHideIndex)
        XCTAssertFalse(result)
    }
    
    func testPadText() {
        let expectValue = "0"
        let result = sut.padTextAt(index: 10)
        
        XCTAssertEqual(expectValue, result)
        
        let index = 0
        
        let expectValue1 = "\(index + 1)"
        let result1 = sut.padTextAt(index: index)
        XCTAssertEqual(expectValue1, result1)
    }
}
