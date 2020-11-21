//
//  TransactionViewModelTests.swift
//  FastMobileTests
//
//  Created by duc on 9/22/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

@testable import FastMobile

import RxSwift
import RxCocoa
import XCTest
import Domain

class TransactionViewModelTests: XCTestCase {
    private let disposeBag = DisposeBag()

    private var transactionUseCase: TransactionUseCaseMock!
    private var transationNavigator: TransactionNavigatorMock!
    private var viewModel: TransactionViewModel!

    override func setUp() {
        super.setUp()

        transactionUseCase = TransactionUseCaseMock()
        transationNavigator = TransactionNavigatorMock()
        viewModel = TransactionViewModel(useCase: transactionUseCase,
                                         navigator: transationNavigator)
    }

    func test_transform_loadSenderTriggerInvoked_senderEmited() {
        let trigger = PublishSubject<Void>()
        let input = createInput(loadSenderTrigger: trigger)
        let output = viewModel.transform(input: input)

        output.sender.drive().disposed(by: disposeBag)
        trigger.onNext(())

        XCTAssert(transactionUseCase.defaultSender_Called)
    }

    func test_transform_selectSenderTriggerInvoked_senderEmited() {
        let trigger = PublishSubject<Void>()
        let input = createInput(selectSenderTrigger: trigger)
        let output = viewModel.transform(input: input)

        output.sender.drive().disposed(by: disposeBag)
        trigger.onNext(())

        XCTAssert(transationNavigator.selectSender_Called)
    }

    func test_transform_selectReceiverTriggerInvoked_receiverEmited() {
        let trigger = PublishSubject<Void>()
        let input = createInput(selectReceiverTrigger: trigger)
        let output = viewModel.transform(input: input)

        output.receiver.drive().disposed(by: disposeBag)
        trigger.onNext(())

        XCTAssert(transationNavigator.selectReceiver_Called)
    }

    func test_transform_updateAmountTriggerInvoked_trackAmountDescription() {
        let trigger = PublishSubject<String>()
        let input = createInput(updateAmountTrigger: trigger)
        let output = viewModel.transform(input: input)
        let amount = [
            "",
            "5",
            "15000"
        ]
        let expectedAmountDescriptions = [
            "Enter amount",
            "Five Dong",
            "Fifteen Thousand Dong"
        ]
        var actualAmountDescriptions: [String] = []

        output.amountDescription
          .do(onNext: { actualAmountDescriptions.append($0) })
          .drive()
          .disposed(by: disposeBag)
        amount.forEach { trigger.onNext($0) }

        XCTAssertEqual(expectedAmountDescriptions, actualAmountDescriptions)
    }

    func test_transform_backTriggerInvoked_dismissEmited() {
        let trigger = PublishSubject<Void>()
        let input = createInput(backTrigger: trigger)
        let output = viewModel.transform(input: input)

        output.dismiss.drive().disposed(by: disposeBag)
        trigger.onNext(())

        XCTAssert(transationNavigator.toHome_Called)
    }

    private func createInput(loadSenderTrigger: Observable<Void> = Observable.just(()),
                             selectSenderTrigger: Observable<Void> = Observable.never(),
                             selectReceiverTrigger: Observable<Void> = Observable.never(),
                             updateAmountTrigger: Observable<String> = Observable.never(),
                             updateMessageTrigger: Observable<String> = Observable.never(),
                             confirmTransactionTrigger: Observable<Void> = Observable.never(),
                             backTrigger: Observable<Void> = Observable.never()) -> TransactionViewModel.Input {
        return TransactionViewModel.Input(
            loadSenderTrigger: loadSenderTrigger.asDriverOnErrorJustComplete(),
            selectSenderTrigger: selectSenderTrigger.asDriverOnErrorJustComplete(),
            selectReceiverTrigger: selectReceiverTrigger.asDriverOnErrorJustComplete(),
            updateAmountTrigger: updateAmountTrigger.asDriverOnErrorJustComplete(),
            updateMessageTrigger: updateMessageTrigger.asDriverOnErrorJustComplete(),
            confirmTransactionTrigger: confirmTransactionTrigger.asDriverOnErrorJustComplete(),
            backTrigger: backTrigger.asDriverOnErrorJustComplete())
    }
}
