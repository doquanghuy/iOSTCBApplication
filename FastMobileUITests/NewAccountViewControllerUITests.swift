//
//  NewAccountViewControllerUITests.swift
//  FastMobile
//
//  Created by Hoa TO. Pham Thi Thanh on 10/1/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import XCTest

class NewAccountViewControllerUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launchArguments = ["UITestMode"]
        app.launch()

        // tap Sign In
        app.buttons["Sign In"].tap()

        // Move to Home
        XCTAssertTrue(app.buttons["Sign In"].waitForExistence(timeout: 4))
        app.scrollViews.otherElements.buttons["Sign In"].tap()
        XCTAssertTrue(app.otherElements["HomeViewController"].waitForExistence(timeout: 3))

        // Tap Transfer
        XCTAssertTrue(app.otherElements["BalanceViewController"].exists)
        let collectionView = app.otherElements["BalanceViewController"].collectionViews
        collectionView.cells.element(boundBy: 1).tap()
        XCTAssertTrue(app.otherElements["TransferOptionsViewController"].waitForExistence(timeout: 1))

        // Select first transfer option
        let tableView = app.otherElements["TransferOptionsViewController"].tables
        tableView.cells.element(boundBy: 0).tap()
        XCTAssertTrue(app.otherElements["TransactionViewController"].waitForExistence(timeout: 1))

        // Select beneficiary
        let beneficiaryButton = app.otherElements["TransactionViewController"].buttons["beneficiary"]
        beneficiaryButton.tap()
        XCTAssertTrue(app.otherElements["BeneficiaryListViewController"].waitForExistence(timeout: 1))

        // Add new account/ card number
        let addAccountButton = app.otherElements["BeneficiaryListViewController"].buttons["add_account"]
        addAccountButton.tap()
        XCTAssertTrue(app.otherElements["NewAccountViewController"].waitForExistence(timeout: 1))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCollectionViewInitForAccount() throws {
        XCTAssertTrue(app.otherElements["NewAccountViewController"].exists)

        let collectionView = app.collectionViews

        // Segment
        let segmentCell = collectionView.cells["0 - 0"]
        let segment = segmentCell.segmentedControls.element(boundBy: 0)
        XCTAssertTrue(segment.buttons["Bank account"].exists)
        XCTAssertTrue(segment.buttons["Bank account"].isSelected == true)
        XCTAssertTrue(segment.buttons["Card number"].exists)
        XCTAssertTrue(segment.buttons["Card number"].isSelected == false)

        // Bank
        let bankCell = collectionView.cells["1 - 0"]
        let bankField = bankCell.textFields["Select the beneficiary bank"]
        XCTAssertTrue((bankField.value as? String) == bankField.placeholderValue)

        // Account
        let accountCell = collectionView.cells["2 - 0"]
        let accountField = accountCell.textFields["Enter bank account"]
        XCTAssertTrue(accountField.exists)
        XCTAssertTrue((accountField.value as? String) == accountField.placeholderValue)

        // Name
        let nameCell = collectionView.cells["2 - 1"]
        let nameField = nameCell.textFields["Enter beneficiary name"]
        XCTAssertTrue(nameField.exists)
        XCTAssertTrue((nameField.value as? String) == nameField.placeholderValue)

        // Save beneficiary
        let switchCell = collectionView.cells["3 - 0"]
        XCTAssertTrue(switchCell.staticTexts["Save the beneficiary"].exists)
        let switchControl = switchCell.switches
        XCTAssertEqual((switchControl.element(boundBy: 0).value as? String),
                       "0",
                       "Switch should be off by default.")

        // Confirm button
        let confirmButton = app.buttons["confirm_button"]
        XCTAssertTrue(confirmButton.isEnabled == false)
    }

    func testCollectionViewInitForCard() throws {
        XCTAssertTrue(app.otherElements["NewAccountViewController"].exists)

        let collectionView = app.collectionViews

        // Segment
        let segmentCell = collectionView.cells["0 - 0"]
        let segment = segmentCell.segmentedControls.element(boundBy: 0)
        segment.buttons["Card number"].tap()

        XCTAssertTrue(segment.buttons["Bank account"].exists)
        XCTAssertTrue(segment.buttons["Bank account"].isSelected == false)
        XCTAssertTrue(segment.buttons["Card number"].exists)
        XCTAssertTrue(segment.buttons["Card number"].isSelected == true)

        // Card
        let cardCell = collectionView.cells["2 - 0"]
        let cardField = cardCell.textFields["Enter card number"]
        XCTAssertTrue(cardField.exists)
        XCTAssertTrue((cardField.value as? String) == cardField.placeholderValue)

        // Save beneficiary
        let switchCell = collectionView.cells["3 - 0"]
        XCTAssertTrue(switchCell.staticTexts["Save the beneficiary"].exists)
        let switchControl = switchCell.switches
        XCTAssertEqual((switchControl.element(boundBy: 0).value as? String),
                       "0",
                       "Switch should be off by default.")

        // Confirm button
        let confirmButton = app.buttons["confirm_button"]
        XCTAssertTrue(confirmButton.isEnabled == false)
    }

    func testSelectBank() throws {
        let collectionView = app.collectionViews
        let bankCell = collectionView.cells["1 - 0"]

        bankCell.tap()
        XCTAssertTrue(app.otherElements["BankListViewController"].waitForExistence(timeout: 1))

        let bankList = app.otherElements["BankListViewController"]
        let cell = bankList.tables.cells.element(boundBy: 0)
        let text = cell.staticTexts.element(boundBy: 1).label
        cell.tap()
        XCTAssertTrue(app.otherElements["NewAccountViewController"].waitForExistence(timeout: 1))

        let bankField = bankCell.textFields["Select the beneficiary bank"]
        XCTAssertTrue((bankField.value as? String) == text)
    }

    func testFillRequiredFieldsForAccount() throws {
        let collectionView = app.collectionViews
        let confirmButton = app.buttons["confirm_button"]
        XCTAssertTrue(confirmButton.isEnabled == false)

        // Fill bank
        collectionView.cells["1 - 0"].tap()
        XCTAssertTrue(app.otherElements["BankListViewController"].waitForExistence(timeout: 1))

        let bankList = app.otherElements["BankListViewController"]
        bankList.tables.cells.element(boundBy: 0).tap()
        XCTAssertTrue(app.otherElements["NewAccountViewController"].waitForExistence(timeout: 1))
        XCTAssertTrue(confirmButton.isEnabled == false)

        // Fill account number
        let accountCell = collectionView.cells["2 - 0"]
        let accountField = accountCell.textFields["Enter bank account"]
        accountField.tap()
        app.typeText("0987654321")
        XCTAssertTrue((accountField.value as? String) == "0987654321")
        XCTAssertTrue(confirmButton.isEnabled == false)

        // Fill account name
        let nameCell = collectionView.cells["2 - 1"]
        let nameField = nameCell.textFields["Enter beneficiary name"]
        nameField.tap()
        app.typeText("Pham Thanh Hoa")
        XCTAssertTrue((nameField.value as? String) == "Pham Thanh Hoa")
        XCTAssertTrue(confirmButton.isEnabled == true)

        // Switch to ON saving beneficiary
        let switchCell = collectionView.cells["3 - 0"]
        let switchControl = switchCell.switches.element(boundBy: 0)
        switchControl.tap()
        XCTAssertTrue(confirmButton.isEnabled == false)

        // Beneficiary name
        let saveCell = collectionView.cells["4 - 0"]
        let saveField = saveCell.textFields["Enter beneficiary name"]
        XCTAssertTrue(saveField.exists)
        XCTAssertTrue((saveField.value as? String) == saveField.placeholderValue)

        saveField.tap()
        app.typeText("Hoa TO")
        XCTAssertTrue((saveField.value as? String) == "Hoa TO")
        XCTAssertTrue(confirmButton.isEnabled == true)
    }

    func testFillRequiredFieldsForCard() throws {
        let collectionView = app.collectionViews

        let segmentCell = collectionView.cells["0 - 0"]
        let segment = segmentCell.segmentedControls.element(boundBy: 0)
        segment.buttons["Card number"].tap()

        let confirmButton = app.buttons["confirm_button"]
        XCTAssertTrue(confirmButton.isEnabled == false)

        // Fill card number
        let cardCell = collectionView.cells["2 - 0"]
        let cardField = cardCell.textFields["Enter card number"]
        cardField.tap()
        app.typeText("0987654321")
        XCTAssertTrue((cardField.value as? String) == "0987654321")
        XCTAssertTrue(confirmButton.isEnabled == true)

        // Switch to ON saving beneficiary
        let switchCell = collectionView.cells["3 - 0"]
        let switchControl = switchCell.switches.element(boundBy: 0)
        switchControl.tap()
        XCTAssertTrue(confirmButton.isEnabled == false)

        // Beneficiary name
        let saveCell = collectionView.cells["4 - 0"]
        let saveField = saveCell.textFields["Enter beneficiary name"]
        XCTAssertTrue(saveField.exists)
        XCTAssertTrue((saveField.value as? String) == saveField.placeholderValue)

        saveField.tap()
        app.typeText("Hoa TO")
        XCTAssertTrue((saveField.value as? String) == "Hoa TO")
        XCTAssertTrue(confirmButton.isEnabled == true)
    }
}
