//
//  RegisterUseCase.swift
//  Domain
//
//  Created by Huy TO. Nguyen Van on 10/30/20.
//

import Foundation

public protocol RegisterUseCase {
    func register(user: User, completion: @escaping TCBResponseCompletion<User>)
}
