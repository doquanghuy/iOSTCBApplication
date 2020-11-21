//
//  SignInUseCase.swift
//  Domain
//
//  Created by vuong on 10/15/20.
//

import Foundation

public protocol LoginUseCase {
    func login(credentials: UserCredentials, completion: @escaping TCBResponseCompletion<User>)
    func adminLogin(completion: @escaping TCBResponseCompletion<Bool>)
    func checkAccountExist(_ username: String, completion: @escaping TCBResponseCompletion<String>)
}
