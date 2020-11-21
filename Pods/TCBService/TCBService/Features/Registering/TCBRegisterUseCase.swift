//
//  TCBRegisterUseCase.swift
//  TCBService
//
//  Created by Huy TO. Nguyen Van on 10/30/20.
//

import TCBDomain
import Backbase

class TCBRegisterUseCase: RegisterUseCase {
    private let authClient: TCBHTTPAuthService

    init(authClient: TCBHTTPAuthService) {
        self.authClient = authClient
    }

    func register(user: User, completion: @escaping TCBResponseCompletion<User>) {
        let request = TCBCreateUserRequest(
            username: user.userCredentials?.email ?? "",
            password: user.userCredentials?.password ?? "",
            firstName: user.firstName ?? "",
            lastName: user.lastName ?? "",
            email: user.email ?? "",
            enabled: user.enabled ?? "true",
            requiredActions: user.requiredActions ?? []
        )
        authClient.createUser(request: request) { result in
            completion(TCBDomain.TCBResult<User>.from(result))
        }
    }
}
