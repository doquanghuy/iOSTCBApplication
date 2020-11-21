//
//  TCBAccountUseCase.swift
//  TCBService
//
//  Created by duc on 10/18/20.
//

import TCBDomain
import Backbase

public class TCBAccountUseCase: TCBDomain.AccountUseCase {
    
    public init() {}
    
    
    public func retrieveData(completion: @escaping (TCBDomain.TCBResult<TCBDomain.ProfileEntity>) -> Void) {
        TCBHTTPIdentityAuthClient().retrieveProfile { (error, profile) in
            if let profile = profile, error == nil {
                completion(.success(profile))
            } else {
                if let _error = error {
                    completion(.error(_error))
                }
            }
        }
    }
    
    public func lookupAccountInfo(name: String, completion: @escaping TCBResponseCompletion<[TCBCard]>) {
        TCBHTTPIdentityAuthClient().lookupAccountInfo(name: name, completion: completion)
    }
}
