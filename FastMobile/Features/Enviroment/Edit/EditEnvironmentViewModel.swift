//
//  EditEnvironmentViewModel.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 11/4/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Domain

//public protocol EditEnvironmentUseCase {
//    func retrieveConfiguration(_ environment: Environment) -> Observable<Configuration>
//}
//
//public class EditEnvironmentUseCaseProvider: EditEnvironmentUseCase {
//
//    public func retrieveConfiguration(_ environment: Environment) -> Observable<Configuration> {
//
//        return Observable.just(Configuration(baseURL: "", realm: "", clientId: ""))
//    }
//}

protocol EditEnvironmentNavigator {
}

class DefaultEditEnvironmentNavigator: EditEnvironmentNavigator {
    
    private let navigationController: UINavigationController?
    private let services: Domain.UseCasesProvider
    
    init(services: Domain.UseCasesProvider,
         navigationController: UINavigationController?) {
        self.services = services
        self.navigationController = navigationController
    }
}

class EditEnvironmentViewModel: ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let saveTrigger: Driver<Void>
        let baseURLTrigger: Driver<String>
        let realmTrigger: Driver<String>
        let clientIdTrigger: Driver<String>
        let dbsBaseURLTrigger: Driver<String>
        let dbsGatewayTrigger: Driver<String>
        let dbsLegalEntityInternalIdTrigger: Driver<String>
        let dbsServiceAgreementIdTrigger: Driver<String>
        let dbsExternalServiceAgreementIdTrigger: Driver<String>
        let dbsSearchIBANTrigger: Driver<String>
    }
    
    struct Output {
        let configuration: Driver<Configuration>
        let saveSuccess: Driver<(Bool?, Environment)>
        //        let saveError: Driver<Void>
    }
    
    private let useCase: Domain.ConfigurationUseCase
    private let navigator: EditEnvironmentNavigator
    private let environment: Environment
    
    init(environment: Environment, useCase: Domain.ConfigurationUseCase, navigator: EditEnvironmentNavigator) {
        self.useCase = useCase
        self.navigator = navigator
        self.environment = environment
    }
    
    func transform(input: Input) -> Output {
        
        let configuration = input.loadTrigger
            .flatMapLatest {[unowned self] _ -> Driver<Configuration> in
                Observable.create { observable in
                    self.useCase.read(environment: self.environment) { result in
                        switch result {
                        case .success(let value):
                            observable.onNext(value ?? Configuration())
                        case .error(let error):
                            observable.onError(error)
                        }
                    }
                    return Disposables.create()
                }.asDriverOnErrorJustComplete()
            }
        
        let inputInfo = Driver.combineLatest(input.baseURLTrigger,
                                             input.realmTrigger,
                                             input.clientIdTrigger,
                                             input.dbsBaseURLTrigger,
                                             input.dbsGatewayTrigger,
                                             input.dbsLegalEntityInternalIdTrigger,
                                             input.dbsServiceAgreementIdTrigger,
                                             input.dbsExternalServiceAgreementIdTrigger)
        let configurationInfo = Driver.combineLatest(inputInfo, input.dbsSearchIBANTrigger, configuration)
        let saveSuccess = input.saveTrigger.withLatestFrom(configurationInfo).map { (arg0) -> Configuration in
            
            let ((baseURL, realm, clientId, dbsBaseURLTrigger, dbsGatewayTrigger, dbsLegalEntityInternalIdTrigger, dbsServiceAgreementIdTrigger, dbsExternalServiceAgreementIdTrigger), dbsSearchIBANTrigger, configuration) = arg0
            
            let identity = Identity(baseURL: baseURL, realm: realm, clientId: clientId)
            
            let dbs = DBS(baseURL: dbsBaseURLTrigger, gateway: dbsGatewayTrigger, legalEntityInternalId: dbsLegalEntityInternalIdTrigger, serviceAgreementId: dbsServiceAgreementIdTrigger, externalServiceAgreementId: dbsExternalServiceAgreementIdTrigger, searchIBANURL: dbsSearchIBANTrigger)
            let custom = Custom(dbs: dbs)
            
            var obj = configuration
            obj.backbase?.identity = identity
            obj.custom = custom
            return obj
        }
        .flatMapLatest {[unowned self] configuration -> Driver<(Bool?, Environment)> in
            Observable.create { observable in
                self.useCase.write(environment: self.environment, configuration: configuration) { result in
                    switch result {
                    case .success(let value):
                        observable.onNext((value, environment))
                    case .error(let error):
                        observable.onError(error)
                    }
                }
                return Disposables.create()
            }.asDriverOnErrorJustComplete()
        }
        
        return Output(configuration: configuration.asDriver(), saveSuccess: saveSuccess.asDriver())
    }
    
}
