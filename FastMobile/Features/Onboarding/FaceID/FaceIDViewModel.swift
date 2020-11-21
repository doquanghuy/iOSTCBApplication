//
//  FaceIDViewModel.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/1/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import LocalAuthentication

class FaceIDViewModel: ViewModelType {
    
    struct Input {
        let enableTrigger: Driver<Void>
        let skipTrigger: Driver<Void>
        let closeTrigger: Driver<Void>
    }
    
    struct Output {
        let enableFaceID: Driver<Void>
        let skipFaceID: Driver<Void>
        let closeFaceID: Driver<Void>
    }

    let navigator: FaceIDNavigator
    
    init(navigator: FaceIDNavigator) {
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        
        let onEnable = input.enableTrigger.do(onNext: { [weak self] in
            self?.authenticateTapped()
        })

        let onSkip = input.skipTrigger.do(onNext: navigator.onSkip)
        let onClose = input.closeTrigger.do(onNext: navigator.onClose)
        
        return Output(enableFaceID: onEnable,
                      skipFaceID: onSkip,
                      closeFaceID: onClose)
    }
    
    private func authenticateTapped() {
        
        let context = LAContext()
        
        context.detectFaceID { [weak self] success, error in
            guard success else { return }
            
            DispatchQueue.main.async {
                self?.navigator.onEnabled()
            }
        }
    }
}
