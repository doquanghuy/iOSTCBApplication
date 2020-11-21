//
//  TCBProfileClient.swift
//  TCBService
//
//  Created by Duong Dinh on 11/9/20.
//

import Foundation
import UserProfileClient

final class UserProfileDataProvider: TCBDataProvider {}

extension UserProfileClient: BBAppClient {
    typealias EnvironmentDataProvider = UserProfileDataProvider
}

class TCBProfileClient: TCBProfileService {
    func getUserProfile(completion: TCBResult<TCBProfile>) {
//        guard let
    }
}
