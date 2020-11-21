//
//  MockTransferOptionsViewModel.swift
//  FastMobileTests
//
//  Created by Dinh Duong on 9/21/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
@testable import FastMobile

class MockTransferOptionsViewModel: TransferOptionsViewModeling {
    var title: String {
        return "MockTransferOptionsViewModel"
    }
    
    var transferOptions: [TransferOption] = []
    
    init(options: [TransferOption]) {
        self.transferOptions = options
    }
}
