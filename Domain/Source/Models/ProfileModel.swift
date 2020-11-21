//
//  ProfileModel.swift
//  Domain
//
//  Created by Thuy Truong Quang on 10/29/20.
//

import Foundation

public struct ProfileModel: Codable {
    
    public let id: String?
    public let username: String?
    public let enabled, totp, emailVerified: Bool
    public let firstName, lastName, email: String?
    public let notBefore: Int?
    public let access: Access
}

public struct Access: Codable {
    public let manageGroupMembership, view, mapRoles, impersonate: Bool
    public let manage: Bool
}
