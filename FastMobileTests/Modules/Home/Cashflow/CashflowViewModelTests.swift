//
//  CashflowViewModelTests.swift
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

class CashflowViewModelTests: XCTestCase {
    private let disposeBag = DisposeBag()
    
    var cashflowUseCase: CashflowUseCaseMock!
    var viewModel: CashflowViewModel!
    
    override func setUp() {
        super.setUp()
        
        cashflowUseCase = CashflowUseCaseMock()
        viewModel = CashflowViewModel(useCase: cashflowUseCase, navigator: DefaultCashflowNavigator(services: cashflowUseCase, navigationController: nil))
    }
    
    func test_transform_loadTriggerInvoked_cashflowEmited() {
        let trigger = PublishSubject<Void>()
        let input = CashflowViewModel.Input(loadTrigger: trigger.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input: input)

        output.cashflow.drive().disposed(by: disposeBag)
        trigger.onNext(())

        XCTAssert(cashflowUseCase.retrieveCashflow_Called)
    }

    func test_transform_loadTriggerInvoked_mapCashflowToViewModels() {
      let trigger = PublishSubject<Void>()
      let input = CashflowViewModel.Input(loadTrigger: trigger.asDriverOnErrorJustComplete())
      let output = viewModel.transform(input: input)
      cashflowUseCase.retrieveCashflow_ReturnValue = Observable.just(createCashflow())

      output.cashflow.drive().disposed(by: disposeBag)
      trigger.onNext(())
      let cashflow = try! output.cashflow.toBlocking().first()!

      XCTAssertNotNil(cashflow)
    }
    
    private func createCashflow() -> Cashflow? {
        return Cashflow(notice: "Your expense hits over 60% income in this month", barChart: [BarChart(textValue: "18.4", title: "Income")])
    }
}
