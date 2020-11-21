//
//  RecentActivityViewModelTest.swift
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

class RecentActivityViewModelTest: XCTestCase {
    private let disposeBag = DisposeBag()
    
    var recentActivityUseCase: RecentActivityUseCaseMock!
    var viewModel: RecentActivityViewModel!
    
    override func setUp() {
        super.setUp()
        
        recentActivityUseCase = RecentActivityUseCaseMock()
        viewModel = RecentActivityViewModel(useCase: recentActivityUseCase, navigator: DefaultRecentActivityNavigator(services: recentActivityUseCase, navigationController: nil))
    }
    
    func test_transform_loadTriggerInvoked_recentActivitiesEmited() {
        let trigger = PublishSubject<Void>()
        let input = RecentActivityViewModel.Input(loadTrigger: trigger.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input: input)

        output.recentActivities.drive().disposed(by: disposeBag)
        trigger.onNext(())

        XCTAssert(recentActivityUseCase.recentActivities_Called)
    }

    func test_transform_loadTriggerInvoked_mapRecentActivitiesToViewModels() {
      let trigger = PublishSubject<Void>()
      let input = RecentActivityViewModel.Input(loadTrigger: trigger.asDriverOnErrorJustComplete())
      let output = viewModel.transform(input: input)
      recentActivityUseCase.recentActivities_ReturnValue = Observable.just(createRecentActivities())

      output.recentActivities.drive().disposed(by: disposeBag)
      trigger.onNext(())
      let recentActivities = try! output.recentActivities.toBlocking().first()!

      XCTAssertEqual(recentActivities.count, 1)
    }
    
    private func createRecentActivities() -> [RecentActivity] {
        return [RecentActivity(amount: -400000, category: "Bill payment", title: "FPT Telecom", logo: "group", avatar: "avatar")]
    }
}
