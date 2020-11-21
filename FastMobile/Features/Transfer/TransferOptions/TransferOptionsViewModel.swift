//
//  TransferOptionsViewModel.swift
//  FastMobile
//
//  Created by Dinh Duong on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

protocol TransferOptionsViewModeling {
    var title: String { get }
    var transferOptions: [TransferOption] { get }
}

class TransferOptionsViewModel: TransferOptionsViewModeling {
    var title: String {
        return "Transfer"
    }
    
    var transferOptions: [TransferOption] = []
    
    init() {
        let another = TransferOption(iconName: "ic_transfer_another", title: "Transfer to another", detail: "The free and fast transfer is prioritized")
        let toMe = TransferOption(iconName: "ic_transfer_me", title: "Transfer to me", detail: "Between your accounts at Techcombank")
        let toStockAccount = TransferOption(iconName: "ic_transfer_stock", title: "Transfer to a stock account", detail: "Money will be received  in 3-5 minutes")
        
        transferOptions.append(another)
        transferOptions.append(toMe)
        transferOptions.append(toStockAccount)
    }
}
