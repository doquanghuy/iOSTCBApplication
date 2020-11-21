//
//  TCBAccountUseCase.swift
//  TCBService
//
//  Created by duc on 10/18/20.
//

import Domain
import Backbase

public class TCBAccountUseCase: Domain.AccountUseCase {
    
    public init() {}
    
    
    public func retrieveData(completion: @escaping (Domain.TCBResult<Domain.ProfileEntity>) -> Void) {
        TCBHTTPIdentityAuthClient().retrieveProfile { (error, profile) in
            if let profile = profile, error == nil {
                completion(.success(profile))
            } else {
                if let _error = error as? Error {
                    completion(.error(_error))
                }
            }
        }
    }
    
    public func lookupAccountInfo(name: String, completion: @escaping TCBResponseCompletion<[TCBCard]>) {
        TCBHTTPIdentityAuthClient().lookupAccountInfo(name: name, completion: completion)
    }
}
