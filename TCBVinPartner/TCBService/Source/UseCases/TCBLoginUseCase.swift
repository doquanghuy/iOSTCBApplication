//
//  TCBLoginUseCase.swift
//  TCBService
//
//  Created by duc on 10/16/20.
//

import Domain
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
//        TCBSessionManager.shared.setAccessTokenDBS(nil)
//        TCBSessionManager.shared.setRefreshTokenDBS(nil)
        
        let httpIdentityAuthClient = TCBHTTPIdentityAuthClient()
        
        var isAdminLogin = true
        var isDBSLogin = true
        
        let dispatchGroup = DispatchGroup()
        
        // 6
        dispatchGroup.enter()
        httpIdentityAuthClient.adminLogin() { (result) in
            switch result {
            case .success(let data): isAdminLogin = data
            case .failure(let error): isAdminLogin = false
            }
            dispatchGroup.leave()
        }
        
//        dispatchGroup.enter()
//        httpIdentityAuthClient.dbsLogin() { (result) in
//            switch result {
//            case .success(let data): isDBSLogin = data
//            case .failure(let error): isDBSLogin = false
//            }
//            dispatchGroup.leave()
//        }
        
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
        /*
        let httpIdentityAuthClient = TCBHTTPIdentityAuthClient()
        httpIdentityAuthClient.getIdentityConfiguration { (config) in
            switch config {
            case .success:
                self.authClient.login(request: request) { result in
                    switch result {
                    case .success(let user):
                        completion(.success(user))
                    case .failure(let error):
                        httpIdentityAuthClient.findAccount(by: credentials.email) { (result) in
                            switch result {
                            case .success(let value):
                                guard let id = value.id else { return }
                                httpIdentityAuthClient.getUserConfiguration(id: id) { result in
                                    switch result {
                                    case .success(_): break
                                    case .failure(let error):
                                        completion(.error(error))
                                    }
                                }
                            case .failure(let error):
                                if error is ErrorEntity && (error as! ErrorEntity).error == "warning" {
                                    self.authClient.login(request: request) { result in
                                        completion(Domain.TCBResult<User>.from(result))
                                    }
                                }
                                completion(.error(error))
                            }
                        }
                        break
                    }
                }
            case .failure(let value):
                completion(.error(value))
            }
        }
 */
    }
    
    func checkAccountExist(_ username: String, completion: @escaping TCBResponseCompletion<String>) {
        let httpIdentityAuthClient = TCBHTTPIdentityAuthClient()
        httpIdentityAuthClient.findAccount(by: username) { (result) in
            switch result {
            case .success:
                completion(.success(username))
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
    
//    func loginDBS(credentials: UserCredentials, completion: @escaping TCBResponseCompletion<User>) {
//        let request = TCBDBSLoginRequest(username: credentials.email,
//                                         password: credentials.password,
//                                         submit: "Login")
//        
//        dbsClient.login(request: request) { (result) in
//            switch result {
//            case .success:
//                let user = User(name: credentials.email, userCredentials: credentials)
//                completion(.success(user))
//            case .failure(let error):
//                completion(.error(error))
//            }
//        }
//    }
}
