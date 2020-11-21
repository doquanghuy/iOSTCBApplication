//
//  ProfileViewModel.swift
//  FastMobile
//
//  Created by Duong Dinh on 11/1/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import Domain
import TCBService
import RxSwift
import RxRelay

protocol ProfileViewModeling {
    var profileError: PublishSubject<Error> { get }
    var isLoading: PublishSubject<Bool> { get }
    var usernameFirstLetter: BehaviorSubject<String?> { get }
    var user: BehaviorRelay<User> { get }
    func updateInfo(user: User)
    func logout()
}

class ProfileViewModel: ProfileViewModeling {
    var user: BehaviorRelay<User>
    var profileError = PublishSubject<Error>()
    var isLoading = PublishSubject<Bool>()
    var usernameFirstLetter: BehaviorSubject<String?>
    let profileUseCase = TCBUseCasesProvider().makeProfileUseCase()
    let accountUseCase = TCBAccountUseCase()
    
    init(user: User) {
        self.user = BehaviorRelay<User>(value: user)
        var usernameFirstLetterValue: String?
        if let firstLetter = user.firstName?.first {
            usernameFirstLetterValue = String(firstLetter).uppercased()
        } else if let firstLetter = user.userCredentials?.email.first {
            usernameFirstLetterValue = String(firstLetter).uppercased()
        } else {
            usernameFirstLetterValue = nil
        }
        usernameFirstLetter = BehaviorSubject<String?>(value: usernameFirstLetterValue)
    }
    
    func updateInfo(user: User) {
        isLoading.onNext(true)
        profileUseCase.updateInfo(user: user) { [weak self] (result) in
            switch result {
            case .success:
                self?.accountUseCase.retrieveData { (profileResult) in
                    self?.isLoading.onNext(false)
                    switch profileResult {
                    case .success(let profile):
                        let credentials = UserCredentials(email: profile?.preferredUsername ?? "", password: "")
                        let user = User(name: "", firstName: profile?.givenName, lastName: profile?.familyName, email: profile?.email, userId: profile?.userID, userCredentials: credentials)
                        self?.user.accept(user)
                        NotificationCenter.default.post(name: .profileDidChange, object: user)
                        if let firstLetter = profile?.givenName.first {
                            self?.usernameFirstLetter.onNext(String(firstLetter).uppercased())
                        } else if let userNameFirstLetter = profile?.preferredUsername.first {
                            self?.usernameFirstLetter.onNext(String(userNameFirstLetter).uppercased())
                        } else {
                            self?.usernameFirstLetter.onNext(nil)
                        }
                    case .error(let error): self?.profileError.onNext(error)
                    }
                }
            case .error(let error):
                self?.isLoading.onNext(false)
                self?.profileError.onNext(error)
            }
        }
    }
    
    func logout() {
        profileUseCase.logOut()
    }
}
