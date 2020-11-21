//
//  LoginViewModelTests.swift
//  FastMobileTests
//
//  Created by Dinh Duong on 9/22/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import XCTest
import RxSwift
@testable import FastMobile

class LoginViewModelTests: XCTestCase {
    var sut: LoginViewModel!
    var navigator: MockSignInNavigator!
    private let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mockUseCase = MockSignInUseCase()
        navigator = MockSignInNavigator()
        sut = LoginViewModel(useCase: mockUseCase, navigator: navigator)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoginFullFields() {
        let signInTrigger = PublishSubject<Void>()
        let input = createInput(email: "duongdh@techcombank.com.vn", password: "123")
        let output = sut.transform(input: input)

        output.loginSuccess.drive().disposed(by: disposeBag)
        signInTrigger.onNext(())

        XCTAssert(navigator.didGoHomeGetCalled)
    }
}

extension LoginViewModelTests {
    
    func createInput(email: String, password: String) -> LoginViewModel.Input {
        return LoginViewModel.Input(emailTrigger: Observable<String>.just(email).asDriverOnErrorJustComplete(),
                                    passwordTrigger: Observable<String>.just(password).asDriverOnErrorJustComplete(),
                                    signInTrigger: Observable<Void>.just(()).asDriverOnErrorJustComplete(), backButtonTrigger: Observable<Void>.just(()).asDriverOnErrorJustComplete())
    }
}
