//
//  OfferingViewModelTests.swift
//  FastMobileTests
//
//  Created by Huy TO. Nguyen Van on 9/22/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

@testable import FastMobile
import XCTest
import RxSwift
import RxBlocking
import Domain

class OfferingViewModelTests: XCTestCase {
    private let disposeBag = DisposeBag()
    
    var offeringUseCase: OfferingUseCaseMock!
    var viewModel: OfferingViewModel!
    
    override func setUp() {
        super.setUp()
        
        offeringUseCase = OfferingUseCaseMock()
        viewModel = OfferingViewModel(useCase: offeringUseCase, navigator: DefaultOfferingNavigator(services: offeringUseCase, navigationController: nil))
    }
    
    func test_transform_loadTriggerInvoked_offeringsEmited() {
        let trigger = PublishSubject<Void>()
        let input = OfferingViewModel.Input(loadTrigger: trigger.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input: input)

        output.offerings.drive().disposed(by: disposeBag)
        trigger.onNext(())

        XCTAssert(offeringUseCase.retrieveOfferings_Called)
    }

    func test_transform_loadTriggerInvoked_mapOfferingsToViewModels() {
      let trigger = PublishSubject<Void>()
      let input = OfferingViewModel.Input(loadTrigger: trigger.asDriverOnErrorJustComplete())
      let output = viewModel.transform(input: input)
      offeringUseCase.retrieveOfferings_ReturnValue = Observable.just(createOfferings())

      output.offerings.drive().disposed(by: disposeBag)
      trigger.onNext(())
      let offerings = try! output.offerings.toBlocking().first()!

      XCTAssertEqual(offerings.count, 2)
    }
    
    private func createOfferings() -> [Offering] {
        return [Offering(backgroundImage: "", logo: "", title: "Get 50k cashback when you spend 1,000,000 đ or more at Starbuck", subtitle: "7 days to activate and spend"),
        Offering(backgroundImage: "", logo: "", title: "Get 50k cashback when you spend 1,000,000 đ or more at Starbuck", subtitle: "6 days to activate and spend")]
    }
}
