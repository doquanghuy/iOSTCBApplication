//
//  WelcomeViewControllerUITests.swift
//  FastMobileUITests
//
//  Created by Duong Dinh on 9/29/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import XCTest

class WelcomeViewControllerUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWelcomeScreenLabels() throws {
        XCTAssertTrue(app.otherElements["WelcomeViewController"].exists)
        XCTAssertTrue(app.staticTexts["Welcome to\n the new \nF@st Mobile"].exists)
        XCTAssertTrue(app.staticTexts["New level of features\nwith new app"].exists)
    }
    
    func testWelcomeScreenButtons() throws {
        XCTAssertTrue(app.buttons["Sign In"].exists)
        XCTAssertTrue(app.buttons["Sign In"].isEnabled)
        XCTAssertTrue(app.buttons["Become a client"].exists)
        XCTAssertTrue(app.buttons["Become a client"].isEnabled)
    }
    
    func testNextScreenIsLogin() {
        app.buttons["Sign In"].tap()
        XCTAssertTrue(app.otherElements["LoginViewController"].exists)
    }
}
