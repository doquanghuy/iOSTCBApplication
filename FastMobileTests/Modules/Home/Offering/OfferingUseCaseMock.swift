//
//  OfferingUseCaseMock.swift
//  FastMobileTests
//
//  Created by Huy TO. Nguyen Van on 9/22/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

@testable import FastMobile
import RxSwift
import Domain

class OfferingUseCaseMock: OfferingUseCase {
    var retrieveOfferings_ReturnValue: Observable<[Offering]> = Observable.just([])
    var retrieveOfferings_Called = false
    
    func retrieveOfferings() -> Observable<[Offering]> {
        retrieveOfferings_Called = true
        return retrieveOfferings_ReturnValue
    }

}
