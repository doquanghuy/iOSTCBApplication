//
//  TCBIdentityAuthClient.swift
//  TCBService
//
//  Created by duc on 10/23/20.
//

import Backbase
import TCBDomain
import AccessControlClient

final class AccessControlDataProvider: TCBDataProvider {}

extension AccessControlClient: BBAppClient {
    typealias EnvironmentDataProvider = AccessControlDataProvider
}

class TCBIdentityAuthClient: BBIdentityAuthClient {
    private var authenticationHandler: ((TCBResult<User>) -> ())?
}

extension TCBIdentityAuthClient: TCBAuthService {
    func login(request: TCBLoginRequest, completion: @escaping (TCBResult<User>) -> ()) {
        authenticationHandler = completion

        authenticate(withUserId: request.username,
                     credentials: request.password,
                     headers: nil,
                     additionalBodyParameters: nil,
                     tokenNames: [],
                     delegate: self)
    }
}

extension TCBIdentityAuthClient: PasswordAuthClientDelegate {
    func authenticationDidSucceed(with headers: [String : String]) {
        let user = User(name: "Identity")
        
        if let accessToken = Backbase.authClient().tokens()["Authorization"]?.replacingOccurrences(of: "bearer ", with: "") {
                    TCBSessionManager.shared.setAccessTokenUser(accessToken)
                }
        
        // Set context
        guard let client = Backbase.registered(client: AccessControlClient.self) as? AccessControlClient else {
            authenticationHandler?(.failure(APIError.unknown))
            return
        }
        
        client.generateUserContext { [weak self] (headers, error) in
            guard let self = self else { return }
            if let error = error {
                self.authenticationHandler?(.failure(error))
            } else {
                self.authenticationHandler?(.success(user))
            }
        }
    }

    func authenticationDidFail(with error: Error) {
        authenticationHandler?(.failure(error))
    }
}
