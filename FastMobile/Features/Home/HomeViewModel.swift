//
//  HomeViewModel.swift
//  FastMobile
//
//  Created by Duong Dinh on 10/5/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import TCBService
import Domain

protocol HomeViewModeling {
    func shouldShowPasscodeScreen() -> Bool
    func getUserProfile(completion: @escaping (ProfileEntity) -> Void)
}

class HomeViewModel: HomeViewModeling {
    
    func shouldShowPasscodeScreen() -> Bool {
        if UIApplication.isRunningTest {
            return false
        }
        return UserDefaults.checkAppCodeStatus() == .firstTimeInstall
    }
    
    let accountUseCase = TCBAccountUseCase()
    
    func getUserProfile(completion: @escaping (ProfileEntity) -> Void) {
        accountUseCase.retrieveData { (result) in
            switch result {
            case .success(let profile):
                if let profile = profile {
                    completion(profile)
                }
            case .error:
                break
            }
        }
    }
}
