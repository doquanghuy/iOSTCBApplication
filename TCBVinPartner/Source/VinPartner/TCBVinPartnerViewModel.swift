//
//  VinPartnerViewModel.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/18/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import TCBService
import Domain

public class TCBVinPartnerViewModel: NSObject {
    private let disposeBag = DisposeBag()
    private(set) var quickActionModels = BehaviorRelay<[TCBQuickActionModel]>(value: [])
    
    func fetchActions(with type: User.UserType = .default) {
        MockResponsitory.fetchActions(with: type.rawValue)
            .bind(to: quickActionModels)
            .disposed(by: disposeBag)
    }
}
