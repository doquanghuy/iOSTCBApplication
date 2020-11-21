//
//  TCBLoginUseCase.swift
//  TCBService
//
//  Created by duc on 10/16/20.
//

import TCBDomain
import Backbase

class TCBLoginUseCase: LoginUseCase {
    private let authClient: TCBAuthService
    private let dbsClient: TCBDBSClient =
        TCBDBSClient()

    init(authClient: TCBAuthService) {
        self.authClient = authClient
    }
    
    func adminLogin(completion: @escaping TCBResponseCompletion<Bool>) {
        TCBSessionManager.shared.setAccessTokenAdmin(nil)
        TCBSessionManager.shared.setRefreshTokenAdmin(nil)
        
        let httpIdentityAuthClient = TCBHTTPIdentityAuthClient()
        
        var isAdminLogin = true
        let isDBSLogin = true
        
        let dispatchGroup = DispatchGroup()
        
        // 6
        dispatchGroup.enter()
        httpIdentityAuthClient.adminLogin() { (result) in
            switch result {
            case .success(let data): isAdminLogin = data
            case .failure(_): isAdminLogin = false
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion(.success(isDBSLogin && isDBSLogin))
        }
    }
    
    func login(credentials: UserCredentials, completion: @escaping TCBResponseCompletion<User>) {
        let request = TCBLoginRequest(
            username: credentials.email,
            password: credentials.password
        )
        
        authClient.login(request: request) { (result) in
            switch result {
            case .success(var user):
                user.email = credentials.email
                completion(.success(user))
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
}
