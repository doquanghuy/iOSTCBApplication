//
//  MockBeneficiaryListViewModel.swift
//  FastMobileTests
//
//  Created by Dinh Duong on 9/22/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import RxSwift

@testable import FastMobile

class MockBeneficiaryListViewModel: BeneficiaryListViewModeling {
    var beneficiaries: [Beneficiary] = []
    var selectedBeneficiary = PublishSubject<Beneficiary>()
    
    var favoriteBeneficiaries: [Beneficiary] = []
    
    init(beneficiaries: [Beneficiary], favoriteBeneficiaries: [Beneficiary]) {
        self.beneficiaries = beneficiaries
        self.favoriteBeneficiaries = favoriteBeneficiaries
    }

    func didSelectBeneficiary(at indexPath: IndexPath) {
    }
}
