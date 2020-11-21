//
//  BankListNavigator.swift
//  FastMobile
//
//  Created by Thuy Truong Quang on 9/25/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import RxSwift
import RxCocoa
import Domain

protocol BankListNavigator {
    func dismissWithBankItem(_ bank: Bank)
    func dismissPopup()
}

//class DefaultBankListNavigator: BankListNavigator {
//
//    private let usecase: BankListUseCase
//
//    init(popupVC: FLPopupViewController) {
//        self.popupVC = popupVC
//       self.usecase = usecase
//    }
//
//    // MARK: - Properties
//    private let dispose = DisposeBag()
//
//    func dismissWithBankItem(_ bank: Bank) {
//    }
//
//    func dismissPopup() {
//        self.popupVC.dismiss()
//    }
//}
