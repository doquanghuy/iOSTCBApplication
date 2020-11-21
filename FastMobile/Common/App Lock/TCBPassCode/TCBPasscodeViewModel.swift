//
//  PAPasscodeViewModel.swift
//  FastMobile
//
//  Created by Duong Dinh on 10/7/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

protocol TCBPasscodeViewModeling {
    var numberOfPads: Int { get }
    func padTextAt(index: Int) -> String
    func shouldHideCellAt(index: Int) -> Bool
    var passCode: String? { get set }
}

class TCBPasscodeViewModel: TCBPasscodeViewModeling {
    
    var numberOfPads: Int {
        return 12
    }
    
    var passCode: String? {
        get {
            return UserDefaults.standard.string(forKey: "passcode")
        }
        set {
            guard let passCode = newValue else { return }
            UserDefaults.standard.setValue(passCode, forKey: "passcode")
        }
    }
    
    func padTextAt(index: Int) -> String {
        var number = "\(index + 1)"
        
        if index == 10 {
            number = "0"
        }
        return number
    }
    
    func shouldHideCellAt(index: Int) -> Bool {
        if index == 9 || index == 11 {
            return true
        }
        return false
    }
}
