//
//  EnviromentViewModel.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 11/4/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Domain
import TCBService

public protocol EnvironmentUseCase {
    func retrieveEnvironments() -> Observable<[Environment]>
}

public class EnvironmentUseCaseProvider: EnvironmentUseCase {

    public func retrieveEnvironments() -> Observable<[Environment]> {
        return Observable.just([.aws, .local])
    }
}

protocol EnvironmentNavigator {
    func toDismiss()
    func changeEnviroment(_ environment: Environment)
}

class DefaultEnvironmentNavigator: EnvironmentNavigator {

    private let navigationController: UINavigationController?
    private let services: EnvironmentUseCase

    init(services: EnvironmentUseCase,
         navigationController: UINavigationController?) {
        self.services = services
        self.navigationController = navigationController
    }
    
    func toDismiss() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func changeEnviroment(_ environment: Environment) {
        TCBEnvironmentManager.shared.switchEnviroment(into: environment)
        navigationController?.dismiss(animated: true, completion: {
//            TCBEnvironmentManager.shared.switchEnviroment(into: environment)
        })
    }
}

class EnvironmentViewModel: ViewModelType {

    struct Input {
        let loadTrigger: Driver<Void>
        let cancelTrigger: Driver<Void>
        let switchEnviromentTrigger: Driver<IndexPath>
    }

    struct Output {
        let environments: Driver<[Environment]>
        let dismiss: Driver<Void>
        let switchEnviroment: Driver<Environment>
    }

    private let useCase: EnvironmentUseCase
    private let navigator: EnvironmentNavigator

    init(useCase: EnvironmentUseCase, navigator: EnvironmentNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }

    func transform(input: Input) -> Output {

        let environments = input.loadTrigger
            .flatMapLatest {_ in
                return self.useCase.retrieveEnvironments()
                    .asDriverOnErrorJustComplete()
        }
        let dismiss = input.cancelTrigger
                .do(onNext: navigator.toDismiss)
        
        let switchEnviroment = Driver.combineLatest(input.switchEnviromentTrigger, environments).flatMapLatest { indexPath, environments in
            Driver.just(environments[indexPath.row])
        }.do(onNext: { [weak self] environment in
            //
            self?.navigator.changeEnviroment(environment)
        })

        return Output(environments: environments.asDriver(), dismiss: dismiss, switchEnviroment: switchEnviroment)
    }

}
