//
//  LoginMockObjects.swift
//  FastMobileTests
//
//  Created by Duong Dinh on 9/22/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import XCTest
import Domain
@testable import FastMobile

class MockSignInUseCase: SignInUseCase {
    func signIn(credentials: UserCredentials) -> Observable<String> {
        return Observable<String>.just("")
    }
    
    func signIn(credentials: UserCredentials) -> Observable<Customer> {
        return Observable.just(Customer())
    }
    
    var didSignInUseCaseGetCalled = false
    func signIn(credentials: UserCredentials) -> Observable<Void> {
        didSignInUseCaseGetCalled = true
        return Observable.just(())
    }
}

class MockSignInNavigator: SignInNavigator {
    func goHome(userDisplayName: String) {
        didGoHomeGetCalled = true
    }
    
    var didGoHomeGetCalled = false
    var didGoBackGetCalled = false
    var didShowErrorGetCalled = false

    func goHome(customer: Customer) {
        didGoHomeGetCalled = true
    }

    func showError() {
        didShowErrorGetCalled = true
    }
    
    func goBack() {
        didGoBackGetCalled = true
    }
}
