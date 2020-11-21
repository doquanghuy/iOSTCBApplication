//
//  UserDefaults+Extensions.swift
//  FastMobile
//
//  Created by Duong Dinh on 10/5/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

let selectedBeneficiaryKey = "setSelectedBeneficiary"

extension UserDefaults {
    
    static func checkAppCodeStatus() -> TCBPasscodeType {
        let passCodeSetup = UserDefaults.standard.value(forKey: "passcode")
        if passCodeSetup != nil {
            return .login
        } else {
            return .firstTimeInstall
        }
    }
    
    static func saveSeletedLatestBeneficiaryToUserDefault(item: Beneficiary?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(item) {
            UserDefaults.standard.setValue(encoded, forKey: selectedBeneficiaryKey)
        }
    }
    
    static func getSeletedLatestBeneficiaryFromUserDefault() -> Beneficiary? {
        if let savedBeneficiary = UserDefaults.standard.object(forKey: selectedBeneficiaryKey) as? Data {
            let decoder = JSONDecoder()
            return try? decoder.decode(Beneficiary.self, from: savedBeneficiary)
        }
        
        return nil
    }
}
