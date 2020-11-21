//
//  TCBAuthService+TCBSessionManager.swift
//  TCBService
//
//  Created by Huy TO. Nguyen Van on 10/30/20.
//
import Backbase

public struct TCBSessionManager {
    public static let shared = TCBSessionManager()
    
    public func setAccessTokenAdmin(_ token: String?) {
        UserDefaults.standard.set(token, forKey: Parameter.accessTokenAdmin.value)
    }
    
    public func getAccessTokenAdmin() -> String? {
        return UserDefaults.standard.object(forKey: Parameter.accessTokenAdmin.value) as? String
    }
    
    public func setRefreshTokenAdmin(_ token: String?) {
        UserDefaults.standard.set(token, forKey: Parameter.refreshTokenAdmin.value)
    }
    
    public func getRefreshTokenAdmin() -> String? {
        return UserDefaults.standard.object(forKey: Parameter.refreshTokenAdmin.value) as? String
    }
    
    public func setAccessTokenUser(_ token: String?) {
        UserDefaults.standard.set(token, forKey: Parameter.accessTokenUser.value)
    }
    
    public func getAccessTokenUser() -> String? {
        return UserDefaults.standard.object(forKey: Parameter.accessTokenUser.value) as? String
    }
    
    public func setRefreshTokenUser(_ token: String?) {
        UserDefaults.standard.set(token, forKey: Parameter.refreshTokenUser.value)
    }
    
    public func getRefreshTokenUser() -> String? {
        return UserDefaults.standard.object(forKey: Parameter.refreshTokenUser.value) as? String
    }
    
    public func setAccessToken(_ username: String?, _ token: String?) {
        switch username {
        case "admin":
            setAccessTokenAdmin(token)
        default:
            setAccessTokenUser(token)
        }
    }
    
    public func setRefreshToken(_ username: String?, _ token: String?) {
        switch username {
        case "admin":
            setRefreshTokenAdmin(token)
        default:
            setRefreshTokenUser(token)
        }
    }
    
    public func clearAllToken() {
        setAccessTokenAdmin(nil)
        setAccessTokenUser(nil)
        setRefreshTokenAdmin(nil)
        setRefreshTokenUser(nil)
    }
}
