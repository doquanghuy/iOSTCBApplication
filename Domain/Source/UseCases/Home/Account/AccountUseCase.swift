//
//  AccountUseCase.swift
//  Domain
//
//  Created by vuong on 10/16/20.
//

import Foundation

public protocol AccountUseCase {
    func retrieveData(completion: @escaping TCBResponseCompletion<ProfileEntity>)
    func lookupAccountInfo(name: String, completion: @escaping TCBResponseCompletion<[TCBCard]>)
}
