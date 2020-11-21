//
//  NewAccountViewModelTests.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 9/29/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import XCTest
@testable import FastMobile
import Domain

class NewAccountViewModelTests: XCTestCase {

    private var accountViewModel: NewAccountViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        accountViewModel = NewAccountViewModel(dataSource: NewAccountDataSource(),
                                               container: UIViewController())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAccountDataSourcesInit() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let dataSources = accountViewModel.currentDataSources
        
        XCTAssertEqual(dataSources.count, 5)
        
        let currentSections = dataSources.map({ $0.type })
        let sections: [Section] = [.segment, .dropList, .textField, .switchItem, .textField]
        XCTAssertEqual(currentSections, sections)
    }
    
    func testSelectAccountSegment()  throws {
        
        accountViewModel.selectedSegment(0, at: IndexPath(item: 0, section: 0))
        
        let dataSources = accountViewModel.currentDataSources
        let segment = dataSources.first(where: { $0.type == .segment })
        let items = segment?.items as? [Segment]
        XCTAssertEqual(items?.count, 2)
        
        let bankItem = items?.first
        XCTAssert(bankItem?.isSelected == true)
        
        let cardItem = items?.last
        XCTAssert(cardItem?.isSelected == false)
    }
    
    func testSelectCardNumberSegment()  throws {
        
        accountViewModel.selectedSegment(1, at: IndexPath(item: 0, section: 0))
        
        let dataSources = accountViewModel.currentDataSources
        let segment = dataSources.first(where: { $0.type == .segment })
        let items = segment?.items as? [Segment]
        XCTAssertEqual(items?.count, 2)
        
        let bankItem = items?.first
        XCTAssert(bankItem?.isSelected == false)
        
        let cardItem = items?.last
        XCTAssert(cardItem?.isSelected == true)
    }
    
    func testSelectBank() throws {
        accountViewModel.selectedSegment(0, at: IndexPath(item: 0, section: 0))
        
        let bank = Bank(name: "Techcombank", logo: "ic_bank_tech", description: "Ngân hàng Kỹ thương Việt Nam")
        accountViewModel.dismissWithBankItem(bank)
        
        let dataSource = accountViewModel.currentDataSources.first(where: { $0.type == .dropList })
        let bankItem = dataSource?.items?.first as? DropItem
        XCTAssert(bankItem != nil)
        XCTAssertEqual(bankItem?.text, "Techcombank")
        XCTAssertEqual(bankItem?.image, UIImage(named: "ic_bank_tech"))
    }
    
    func testFillBeneficiaryAccount() throws {
        // select account segment
        accountViewModel.selectedSegment(0, at: IndexPath(item: 0, section: 0))
        
        // fill account number
        accountViewModel.textValueChanged("0987654321", at: IndexPath(item: 0, section: 2))
        
        let dataSources = accountViewModel.currentDataSources
        let segment = dataSources.first(where: { $0.type == .textField })
        let items = segment?.items as? [TextFieldConfig]
        XCTAssertEqual(items?.count, 2)
        
        let accountNumber = items?.first
        XCTAssertEqual(accountNumber?.text, "0987654321")
    }
    
    func testFillBeneficiaryName() throws {
        // select account segment
        accountViewModel.selectedSegment(0, at: IndexPath(item: 0, section: 0))
        
        // fill account number
        accountViewModel.textValueChanged("Pham Thanh Hoa", at: IndexPath(item: 1, section: 2))
        
        let dataSources = accountViewModel.currentDataSources
        let segment = dataSources.first(where: { $0.type == .textField })
        let items = segment?.items as? [TextFieldConfig]
        XCTAssertEqual(items?.count, 2)
        
        let accountNumber = items?.last
        XCTAssertEqual(accountNumber?.text, "Pham Thanh Hoa")
    }
    
    func testOnSaveBeneficiary() throws {
        // select account segment
        accountViewModel.selectedSegment(0, at: IndexPath(item: 0, section: 0))
        
        // switch to ON
        accountViewModel.switchValueChanged(true, indexPath: IndexPath(item: 0, section: 3))
        
        let dataSources = accountViewModel.currentDataSources
        let switchItem = dataSources.first(where: { $0.type == .switchItem })
        let switchConfig = switchItem?.items?.first as? Switch
        XCTAssert(switchConfig != nil)
        XCTAssert(switchConfig?.isOn == true)
        
        let textField = dataSources.last(where: { $0.type == .textField })
        XCTAssertEqual(textField?.items?.count, 1)
        
        let textConfig = textField?.items?.first as? TextFieldConfig
        XCTAssert(textConfig != nil)
        XCTAssertEqual(textConfig?.placeHolder, "Enter beneficiary name")
        XCTAssert(textConfig?.text?.isEmpty ?? true)
    }
    
    func testOffSaveBeneficiary() throws {
        // select account segment
        accountViewModel.selectedSegment(0, at: IndexPath(item: 0, section: 0))
        
        // switch to OFF
        accountViewModel.switchValueChanged(false, indexPath: IndexPath(item: 0, section: 3))
        
        let dataSources = accountViewModel.currentDataSources
        let switchItem = dataSources.first(where: { $0.type == .switchItem })
        let switchConfig = switchItem?.items?.first as? Switch
        XCTAssert(switchConfig != nil)
        XCTAssert(switchConfig?.isOn == false)
        
        let textField = dataSources.last(where: { $0.type == .textField })
        XCTAssert(textField?.items?.isEmpty ?? true)
    }
    
    func testSaveBeneficiaryName() throws {
        // select account segment
        accountViewModel.selectedSegment(0, at: IndexPath(item: 0, section: 0))
        
        // switch to ON
        accountViewModel.switchValueChanged(true, indexPath: IndexPath(item: 0, section: 3))
        
        // fill account number
        accountViewModel.textValueChanged("Hoa TO", at: IndexPath(item: 0, section: 4))
        
        let dataSources = accountViewModel.currentDataSources
        let textField = dataSources.last(where: { $0.type == .textField })
        let config = textField?.items?.first as? TextFieldConfig
        
        XCTAssert(config != nil)
        XCTAssertEqual(config?.text, "Hoa TO")
    }
    
    func testCollectionDataSourcesForAccount() throws {
        // select account segment
        accountViewModel.selectedSegment(0, at: IndexPath(item: 0, section: 0))
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let numberOfSections = accountViewModel.numberOfSections(in: collectionView)
        XCTAssertEqual(numberOfSections, 5)
        
        XCTAssertEqual(accountViewModel.collectionView(collectionView, numberOfItemsInSection: 0), 1)
        XCTAssertEqual(accountViewModel.collectionView(collectionView, numberOfItemsInSection: 1), 1)
        XCTAssertEqual(accountViewModel.collectionView(collectionView, numberOfItemsInSection: 2), 2)
        XCTAssertEqual(accountViewModel.collectionView(collectionView, numberOfItemsInSection: 3), 1)
        
        // switch to ON
        accountViewModel.switchValueChanged(true, indexPath: IndexPath(item: 0, section: 3))
        XCTAssertEqual(accountViewModel.collectionView(collectionView, numberOfItemsInSection: 4), 1)
    }
    
    func testCollectionDataSourcesForCard() throws {
        // select account segment
        accountViewModel.selectedSegment(1, at: IndexPath(item: 0, section: 0))
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let numberOfSections = accountViewModel.numberOfSections(in: collectionView)
        XCTAssertEqual(numberOfSections, 5)
        
        XCTAssertEqual(accountViewModel.collectionView(collectionView, numberOfItemsInSection: 0), 1)
        XCTAssertEqual(accountViewModel.collectionView(collectionView, numberOfItemsInSection: 1), 0)
        XCTAssertEqual(accountViewModel.collectionView(collectionView, numberOfItemsInSection: 2), 1)
        XCTAssertEqual(accountViewModel.collectionView(collectionView, numberOfItemsInSection: 3), 1)
        
        // switch to ON
        accountViewModel.switchValueChanged(true, indexPath: IndexPath(item: 0, section: 3))
        XCTAssertEqual(accountViewModel.collectionView(collectionView, numberOfItemsInSection: 4), 1)
    }
}
