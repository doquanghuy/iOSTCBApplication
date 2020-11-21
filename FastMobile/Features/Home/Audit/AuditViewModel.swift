//
//  AuditViewModel.swift
//  FastMobile
//
//  Created by Duong Dinh on 11/16/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Domain

class AuditViewModel: ViewModelType {

    struct Input {
        let loadTrigger: Driver<Void>
        let refeshDataTrigger: Driver<Void>
    }

    struct Output {
        let recentActivities: Driver<[AuditMessage]>
    }

    private let useCase: AuditUseCase
    private let navigator: AuditNavigator
    private let userName: String

    init(useCase: AuditUseCase, navigator: AuditNavigator, userName: String) {
        self.useCase = useCase
        self.navigator = navigator
        self.userName = userName
    }

    func transform(input: Input) -> Output {
        let sender = Driver.merge(input.loadTrigger, input.refeshDataTrigger)
        
        let recentActivities = sender.flatMapLatest {[unowned self] _ -> Driver<[AuditMessage]> in
                Observable.create { observable in
                    self.useCase.getAuditMessages(username: userName) { messageResponse in
                        switch messageResponse {
                        case .success(let response):
                            if let messages = response?.auditMessages {
                                observable.onNext(messages)
                            } else {
                                observable.onNext([])
                            }
                        case .error(let error):
                            observable.onError(error)
                        }
                    }
                    return Disposables.create()
                }.asDriverOnErrorJustComplete()
        }

        return Output(recentActivities: recentActivities)
    }
}
