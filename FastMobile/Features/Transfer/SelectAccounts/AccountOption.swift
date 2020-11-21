//
//  TransferOption.swift
//  FastMobile
//
//  Created by Dinh Duong on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import UIKit

enum AccountType: String {
    case current
    case savings
    case termDeposit
    case debitCards
    case creditCards
    case loan
    case investment
    case transactions = "Transaction Account"
    case mobile = "Mobile Account"
    case salary = "Salary Account"
    
    var name: String? {
        switch self {
        case .transactions:
            return "Tài khoản thanh toán"
        case .mobile:
            return "Tài khoản mobile"
        case .salary:
            return "Tài khoản lương"
        default: return nil
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .transactions:
            return UIImage(named: "ic_ac_type_current")
        case .mobile:
            return UIImage(named: "ic_ac_type_savings")
        case .salary:
            return UIImage(named: "ic_ac_type_term")
        default:
            return UIImage(named: "ic_ac_type_current")
        }
    }
}

struct AccountOption: Equatable {
    let type: AccountType
    let id: String
    let accountNumber: String
    let name: String?
    let amount: Double
}
