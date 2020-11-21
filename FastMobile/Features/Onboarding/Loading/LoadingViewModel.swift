//
//  LoadingViewModel.swift
//  FastMobile
//
//  Created by Duong Dinh on 11/2/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import TCBService
import Domain

class LoadingViewModel {
    
    func adminLogin(completion: @escaping TCBResponseCompletion<Bool>) {
        TCBUseCasesProvider()
            .makeLoginUseCase()
            .adminLogin(completion: completion)
    }
}
