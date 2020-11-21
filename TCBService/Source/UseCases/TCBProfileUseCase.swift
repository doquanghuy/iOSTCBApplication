//
//  TCBProfileUseCase.swift
//  TCBService
//
//  Created by Nguyen Van Huy on 2020/11/01.
//

import Domain
import Backbase

public class TCBProfileUseCase: ProfileUseCase {
    private let authClient: TCBHTTPAuthService

    init(authClient: TCBHTTPAuthService) {
        self.authClient = authClient
    }
    
    public func updateInfo(user: User, completion: @escaping TCBResponseCompletion<TCBUpdateInfoUserResponse>) {
        let request = TCBUpdateInfoUserRequest(
            userId: user.userId ?? "",
            username: user.name ?? "",
            firstName: user.firstName ?? "",
            lastName: user.lastName ?? "",
            email: user.email ?? ""
        )
        authClient.updateInfoUser(request: request) { result in
            completion(Domain.TCBResult<TCBUpdateInfoUserResponse>.from(result))
        }
    }
    
    public func logOut() {
        authClient.logOut()
    }
}
