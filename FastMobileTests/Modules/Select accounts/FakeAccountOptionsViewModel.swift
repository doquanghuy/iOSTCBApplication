//
//  FakeAccountOptionsViewModel.swift
//  FastMobileTests
//
//  Created by Dinh Duong on 9/22/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import RxSwift
@testable import FastMobile

class MockAccountOptionsViewModel: AccountOptionsViewModeling {
    var selectedCellIndexPath = IndexPath(item: 0, section: 0)
    var selectedAccountOption = PublishSubject<AccountOption>()

    func didSelectAccountOption(at indexPath: IndexPath) {
    }

    var title: String {
        return "MockAccountOptionsViewModel"
    }
    
    var accountOptions: [AccountOption] = []
    
    init(options: [AccountOption]) {
        self.accountOptions = options
    }
}
