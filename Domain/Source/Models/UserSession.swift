//
//  UserSession.swift
//  TCBPay
//
//  Created by Dinh Duong on 9/10/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import Foundation

public class UserSession: Codable {

  // MARK: - Properties
  public let profile: LegacyUser
  public let remoteSession: RemoteUserSession

  // MARK: - Methods
  public init(profile: LegacyUser, remoteSession: RemoteUserSession) {
    self.profile = profile
    self.remoteSession = remoteSession
  }
}

extension UserSession: Equatable {
  
  public static func == (lhs: UserSession, rhs: UserSession) -> Bool {
    return lhs.profile == rhs.profile &&
           lhs.remoteSession == rhs.remoteSession
  }
}
