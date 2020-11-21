//
//  SuggestedAmountTests.swift
//  FastMobileTests
//
//  Created by Pham Thanh Hoa on 9/28/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import XCTest
@testable import FastMobile

class SuggestedAmountTests: XCTestCase {

    private var textField: UITextField!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        textField.setupCustomNumberKeyboard(with: UIScreen.main.bounds.width)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuggestedAmountSetup() throws {
        let accessoryView = textField.inputAccessoryView as? SuggestedAmountView
        
        XCTAssert(accessoryView != nil)
        XCTAssert(accessoryView?.textField === textField)
        XCTAssert(accessoryView?.collectionView != nil)
    }
    
    func testSuggestedAmountValues() throws {
        guard let accessoryView = textField.inputAccessoryView as? SuggestedAmountView else {
            XCTAssert(false)
            return
        }
        
        textField.text = "1"
        textField.sendActions(for: .editingChanged)
        XCTAssertEqual(accessoryView.inputKey, "1")
        
        var outputs = ["1000", "10000", "100000"].compactMap({ $0.formattedNumber })
        XCTAssertEqual(accessoryView.suggestionKeys, outputs)
        
        textField.text = "99999"
        textField.sendActions(for: .editingChanged)
        XCTAssertEqual(accessoryView.inputKey, "99999")
        
        outputs = ["99999000", "999990000", "9999900000"].compactMap({ $0.formattedNumber })
        XCTAssertEqual(accessoryView.suggestionKeys, outputs)
        
        textField.text = "100000"
        textField.sendActions(for: .editingChanged)
        XCTAssertEqual(accessoryView.inputKey, "100000")
        XCTAssertEqual(accessoryView.suggestionKeys, outputs, "Suggestion amounts can not exceed 100000 * 100000")
        
        textField.text = "0"
        textField.sendActions(for: .editingChanged)
        XCTAssertEqual(accessoryView.inputKey, "0", "Suggestion amount can not be smaller or equal 0")
        XCTAssertEqual(accessoryView.suggestionKeys.count, 0)
    }
    
    func testCollectionDataSources() throws {
        guard let accessoryView = textField.inputAccessoryView as? SuggestedAmountView else {
            XCTAssert(false)
            return
        }
        
        let collectionView = accessoryView.collectionView
        
        textField.text = "123"
        textField.sendActions(for: .editingChanged)
        
        let outputs = ["123000", "1230000", "12300000"].compactMap({ $0.formattedNumber })
        
        for i in 0 ..< outputs.count {
            let cell = accessoryView.collectionView(collectionView,
                                                    cellForItemAt: IndexPath(item: i, section: 0)) as? SuggestedKeyboardCell
            let value = "\(outputs[i]) \(accessoryView.unit)"
            XCTAssertEqual(cell?.key, value)
        }
    }
}
