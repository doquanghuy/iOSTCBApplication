//
//  ProfileUseCase.swift
//  Domain
//
//  Created by Nguyen Van Huy on 2020/11/01.
//

import Foundation

public protocol ProfileUseCase {
    func updateInfo(user: User, completion: @escaping TCBResponseCompletion<TCBUpdateInfoUserResponse>)
    func logOut()
}
