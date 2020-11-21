//
//  NewAccountDataSource.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 9/29/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import UIKit

final class NewAccountDataSource: NSObject {
    
    var bankDataSources: [DataSource] = []
    var cardDataSources: [DataSource] = []
    
    override init() {
        super.init()
        
        bankDataSources = [/*DataSource(type: .segment,
                                      isHorizontal: true,
                                      items: [Segment(title: "Bank account", isSelected: true),
                                              Segment(title: "Card number", isSelected: false)]),*/
                           DataSource(type: .dropList,
                                      items: [DropItem(placeHolder: "Select the beneficiary bank")]),
                           DataSource(type: .textField,
                                      items: [TextFieldConfig(placeHolder: "Enter bank account",
                                                              keyboardType: .numberPad,
                                                              inputHandler: TextInputHandler.accountId,
                                                              editable: false),
                                              TextFieldConfig(placeHolder: "Enter beneficiary name",
                                                              editable: false)]),
                           DataSource(type: .switchItem, items: [Switch(title: "Save the beneficiary",
                                                                        isOn: false)]),
                           DataSource(type: .textField)]
        
        cardDataSources = [DataSource(type: .segment,
                                      isHorizontal: true,
                                      items: [Segment(title: "Bank account", isSelected: true),
                                              Segment(title: "Card number", isSelected: false)]),
                           DataSource(type: .dropList),
                           DataSource(type: .textField,
                                      items: [TextFieldConfig(placeHolder: "Enter card number",
                                                              keyboardType: .numberPad,
                                                              inputHandler: TextInputHandler.accountId)]),
                           DataSource(type: .switchItem, items: [Switch(title: "Save the beneficiary",
                                                                        isOn: false)]),
                           DataSource(type: .textField)]
    }
    
    func updateBankDataSource(at index: Int, element: DataSource) {
        bankDataSources[index] = element
    }
    
    func updateCardDataSource(at index: Int, element: DataSource) {
        cardDataSources[index] = element
    }
}
