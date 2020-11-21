//
//  MessageViewModel.swift
//  FastMobile
//
//  Created by duc on 9/14/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift
import Domain

class MessageViewModel {
    private let disposeBag = DisposeBag()
    private(set) var cardViewModels = BehaviorRelay<[Message]>(value: [])

    private let useCase: MessagesUseCase

    init(useCase: MessagesUseCase) {
        self.useCase = useCase
    }
    
    func fetchMessages() {
        useCase.fetchMessages { [unowned self] result in
            switch result {
            case .success(let messages):
                self.cardViewModels.accept(messages ?? [])
            default:
                break
            }
        }
    }
}
