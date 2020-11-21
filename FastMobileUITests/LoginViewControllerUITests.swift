//
//  LoginViewControllerUITests.swift
//  FastMobileUITests
//
//  Created by Duong Dinh on 9/29/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import XCTest

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()
        for _ in 0..<stringValue.count {
            self.typeText(XCUIKeyboardKey.delete.rawValue)
        }

        self.typeText(text)
    }
}

class LoginViewControllerUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        app.buttons["Sign In"].tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginEmptyEmailField() throws {
        XCTAssertTrue(app.otherElements["LoginViewController"].exists)
        let scrollViewsQuery = app.scrollViews
        let elementsQuery2 = scrollViewsQuery.otherElements
        
        XCTAssertTrue(elementsQuery2.textFields["Email"].waitForExistence(timeout: 3))
        
        elementsQuery2.textFields["Email"].tap()
        elementsQuery2.textFields["Email"].tap()
        app.staticTexts["Select All"].tap()
        app.staticTexts["Cut"].tap()
        elementsQuery2.textFields["Email"].typeText("")
        
        XCTAssertFalse(scrollViewsQuery.otherElements.buttons["Sign In"].isEnabled)
    }
    
    func testLoginEmptyPasswordField() throws {
        XCTAssertTrue(app.otherElements["LoginViewController"].exists)
        let scrollViewsQuery = app.scrollViews
        let elementsQuery2 = scrollViewsQuery.otherElements
        
        XCTAssertTrue(elementsQuery2.secureTextFields["Password"].waitForExistence(timeout: 3))
        elementsQuery2.secureTextFields["Password"].tap()
        elementsQuery2.secureTextFields["Password"].clearAndEnterText(text: "")
        elementsQuery2.secureTextFields["Password"].typeText("")
        XCTAssertFalse(scrollViewsQuery.otherElements.buttons["Sign In"].isEnabled)
    }
    
    func testUIComponentsExist() {
        XCTAssertTrue(app.otherElements["LoginViewController"].exists)
        
        let scrollViewsQuery = app/*@START_MENU_TOKEN@*/.scrollViews/*[[".otherElements[\"LoginViewController\"].scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let backarrowButton = scrollViewsQuery.otherElements.buttons["backArrow"]
        XCTAssertTrue(backarrowButton.waitForExistence(timeout: 2))
        XCTAssertTrue(backarrowButton.isEnabled)
    }
    
    func testBackButtonAction() {
        XCTAssertTrue(app.otherElements["LoginViewController"].exists)
        let backarrowButton = app.scrollViews.otherElements.buttons["backArrow"]
        XCTAssertTrue(backarrowButton.waitForExistence(timeout: 2))
        XCTAssertTrue(backarrowButton.isEnabled)
        backarrowButton.tap()
        XCTAssertTrue(app.otherElements["WelcomeViewController"].waitForExistence(timeout: 2))
    }
}
