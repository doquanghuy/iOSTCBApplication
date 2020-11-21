//
//  OfferingViewModel.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 9/10/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

public protocol OfferingUseCase {
    func retrieveOfferings() -> Observable<[Offering]>
}

public class OfferingUseCaseProvider: OfferingUseCase {

    public func retrieveOfferings() -> Observable<[Offering]> {
        if let url = Bundle.main.url(forResource: "Offerings", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Offering].self, from: data)
                return Observable.of(jsonData)
            } catch {
                print("error:\(error)")
            }
        }
        return Observable.just([])
    }
}

protocol OfferingNavigator {
}

class DefaultOfferingNavigator: OfferingNavigator {

    private let navigationController: UINavigationController?
    private let services: OfferingUseCase

    init(services: OfferingUseCase,
         navigationController: UINavigationController?) {
        self.services = services
        self.navigationController = navigationController
    }
}

class OfferingViewModel: ViewModelType {

    struct Input {
        let loadTrigger: Driver<Void>
    }

    struct Output {
        let offerings: Driver<[Offering]>
//        let error: Driver<Error>
    }

    private let useCase: OfferingUseCase
    private let navigator: OfferingNavigator

    init(useCase: OfferingUseCase, navigator: OfferingNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }

    func transform(input: Input) -> Output {

        let offerings = input.loadTrigger
            .flatMapLatest {_ in
                return self.useCase.retrieveOfferings()
                    .asDriverOnErrorJustComplete()
        }

        return Output(offerings: offerings.asDriver())
    }

}

extension ObservableType {

    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }

    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
