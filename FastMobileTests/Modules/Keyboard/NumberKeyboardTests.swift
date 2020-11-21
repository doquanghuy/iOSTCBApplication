//
//  NumberKeyboardTests.swift
//  FastMobileTests
//
//  Created by Pham Thanh Hoa on 9/28/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import XCTest
@testable import FastMobile

class NumberKeyboardTests: XCTestCase {

    private var textField: UITextField!
    
    let keys: [Key] = [Key(type: .number, value: "1"),
                       Key(type: .number, value: "2"),
                       Key(type: .number, value: "3"),
                       Key(type: .delete),
                       Key(type: .number, value: "4"),
                       Key(type: .number, value: "5"),
                       Key(type: .number, value: "6"),
                       Key(type: .enter),
                       Key(type: .number, value: "7"),
                       Key(type: .number, value: "8"),
                       Key(type: .number, value: "9"),
                       Key(type: .number, value: "0"),
                       Key(type: .unit, value: "000")]
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        textField.setupCustomNumberKeyboard(with: UIScreen.main.bounds.width)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumberKeyboardSetup() throws {
        let inputView = textField.inputView as? NumberKeyboardView
        
        XCTAssert(inputView != nil)
        XCTAssert(inputView?.delegate === textField)
        
        XCTAssertEqual(keys.map({ $0.type }), inputView?.keys.map({ $0.type }))
        XCTAssertEqual(keys.map({ $0.value }), inputView?.keys.map({ $0.value }))
        
        guard let collectionView = inputView?.collectionView else {
            XCTAssert(false)
            return
        }
        
        XCTAssertEqual(inputView?.collectionView(collectionView, numberOfItemsInSection: 0), keys.count)
    }
    
    func testNumberKeyboardSeparatedValues() throws {
        guard let inputView = textField.inputView as? NumberKeyboardView else {
            XCTAssert(false)
            return
        }
        
        let collectionView = inputView.collectionView
        
        for i in 0 ..< keys.count {
            textField.text = nil
            textField.becomeFirstResponder()
            
            let indexPath = IndexPath(item: i, section: 0)
            inputView.collectionView(collectionView, didSelectItemAt: indexPath)
            
            let key = keys[safe: i]
            
            switch key?.type {
            case .delete:
                XCTAssertEqual(textField.text?.count, 0)
            case .enter:
                XCTAssert(!textField.isFirstResponder)
            case .unit:
                XCTAssertEqual(textField.text?.count, 0)
                XCTAssert(textField.text?.isEmpty ?? true)
            default:
                if key?.value == "0" {
                    XCTAssertEqual(textField.text?.count, 0)
                    XCTAssert(textField.text?.isEmpty ?? true)
                } else {
                    XCTAssertEqual(textField.text?.count, key?.value?.count)
                    XCTAssertEqual(textField.text, key?.value)
                }
            }
        }
    }
    
    func testNumberKeyboardIntegratedValues() throws {
        guard let inputView = textField.inputView as? NumberKeyboardView else {
            XCTAssert(false)
            return
        }
        
        let collectionView = inputView.collectionView
        textField.text = nil
        textField.becomeFirstResponder()
        
        inputView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 11, section: 0)) // 0
        XCTAssert(textField.text?.isEmpty ?? true, "Amount can not start with 0")
        
        inputView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 0, section: 0)) // 1
        inputView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 1, section: 0)) // 2
        inputView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 2, section: 0)) // 3
        XCTAssertEqual(textField.text, "123")
        
        inputView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 3, section: 0)) // delete
        XCTAssertEqual(textField.text, "12")
        
        inputView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 4, section: 0)) // 4
        inputView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 5, section: 0)) // 5
        inputView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 6, section: 0)) // 6
        XCTAssertEqual(textField.text, "12456".formattedNumber)
        
        inputView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 7, section: 0)) // Enter
        XCTAssertEqual(textField.text, "12456".formattedNumber)
        XCTAssert(!textField.isFirstResponder)
        
        textField.becomeFirstResponder()
        inputView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 8, section: 0)) // 7
        inputView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 9, section: 0)) // 8
        inputView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 10, section: 0)) // 9
        inputView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 11, section: 0)) // 0
        XCTAssertEqual(textField.text, "124567890".formattedNumber)
        
        inputView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 12, section: 0)) // 000
        XCTAssertEqual(textField.text, "124567890000".formattedNumber)
        XCTAssertEqual(textField.text?.count, 15)
        
        inputView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 12, section: 0)) // 000
        XCTAssertEqual(textField.text, "124567890000".formattedNumber, "Amount can not exceed 12 characters")
        XCTAssertEqual(textField.text?.count, 15)
    }
}
