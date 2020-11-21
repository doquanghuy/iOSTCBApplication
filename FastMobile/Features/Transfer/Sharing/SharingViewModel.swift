//
//  SharingViewModel.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/25/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public protocol SharingUseCase {
}

public class SharingUseCaseProvider: SharingUseCase {
}

protocol SharingNavigator {
    func dismiss()
}

class DefaultSharingNavigator: SharingNavigator {
    private let navigationController: UINavigationController
    private let services: SharingUseCase

    init(services: SharingUseCase,
         navigationController: UINavigationController) {
        self.services = services
        self.navigationController = navigationController
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}

class SharingViewModel: ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let dismissTrigger: Driver<Void>
    }
    
    struct Output {
        let transactionImage: Driver<UIImage?>
        let dismiss: Driver<Void>
    }
    
    private let useCase: SharingUseCase
    private let navigator: SharingNavigator
    private var transactionImage: UIImage?
    
    init(transactionImage: UIImage?, useCase: SharingUseCase, navigator: SharingNavigator) {
        self.transactionImage = transactionImage
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {

        let transactionImage = input.loadTrigger
            .flatMapLatest {_ in
                return Driver.just(self.transactionImage)
        }
        
        let dismiss = input.dismissTrigger
        .do(onNext: {[unowned self]  _ in
            self.navigator.dismiss()
        })
        
        return Output(transactionImage: transactionImage, dismiss: dismiss)
    }
}
