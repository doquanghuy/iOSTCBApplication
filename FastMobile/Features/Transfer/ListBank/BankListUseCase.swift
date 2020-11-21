//
//  BankListUseCase.swift
//  FastMobile
//
//  Created by Thuy Truong Quang on 9/25/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import Domain

protocol BankListUseCase {
    func listBank(_ keyword: String) -> Observable<[Bank]>
}

class DefaultBankListUseCase: BankListUseCase {
    
    var repo: MockResponsitory
    
    init(repo: MockResponsitory) {
        self.repo = repo
    }
    
    func listBank(_ keyword: String) -> Observable<[Bank]> {
        let fetchBank = repo.fetchBank()
        if !keyword.isEmpty {
            return fetchBank.map { $0.filter { $0.name.lowercased().contains(keyword.lowercased()) } }
        }
        return fetchBank
    }
}
