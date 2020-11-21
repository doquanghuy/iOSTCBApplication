//
//  ConfigurationUseCase.swift
//  Domain
//
//  Created by Huy Van Nguyen on 11/4/20.
//

import Foundation

public enum Environment: CaseIterable {
    case aws
    case local
    
    public var text: String {
        switch self {
        case .aws:
            return "AWS"
        case .local:
            return "Local"
        }
    }
    
    public var fileName: String {
        switch self {
        case .local:
            return "config-local.json"
        case .aws:
            return "config-aws.json"
        }
    }
}

public struct Configuration: Codable {
    /*
     {
         "backbase": {
             "serverURL": "http://bb3.poc.tcbdevsecops.cloud:7777",
             "version": "6.1.5",
             "experience": "retail-banking-mobile-sepa",
             "localModelPath": "$(contextRoot)/conf/offline-model.json",
             "identity": {
                 "baseURL": "http://13.212.148.167:8180",
                 "realm": "master",
                 "clientId": "security-admin-console"
             }
         },
         "security": {
             "allowedDomains": [
                 "*"
             ]
         },
         "development": {
             "debugEnable": true
         },
     "custom": {
         "dbs": {
            "baseURL": "http://192.168.0.145:8086",
            "gateway": "http://192.168.0.145:7777/api"
            "legalEntityInternalId": "402881ea75a8d3370175a8d5363e0000",
            "serviceAgreementId": "402881ea75a7ce5f0175a7d438eb0001",
            "externalServiceAgreementId": "Techcombank_External"
         }
     }
     }
     */
    
    public var backbase: BackbaseConfiguration?
    public var security: Security?
    public var development: Development?
    public var custom: Custom?
    
    public init(backbase: BackbaseConfiguration? = nil, security: Security? = nil, development: Development? = nil, custom: Custom? = nil) {
        self.backbase = backbase
        self.security = security
        self.development = development
        self.custom = custom
    }
    
}

public struct BackbaseConfiguration: Codable {
    public var serverURL: String?
    public var version: String?
    public var experience: String?
    public var localModelPath: String?
    public var identity: Identity?
    
    public init(serverURL: String?, version: String?, experience: String?, localModelPath: String?, identity: Identity?) {
        self.serverURL = serverURL
        self.version = version
        self.experience = experience
        self.localModelPath = localModelPath
        self.identity = identity
    }
}

public struct Identity: Codable {
    public var baseURL: String?
    public var realm: String?
    public var clientId: String?
    
    public init(baseURL: String?, realm: String?, clientId: String?) {
        self.baseURL = baseURL
        self.realm = realm
        self.clientId = clientId
    }
}

public struct Security: Codable {
    public var allowedDomains: [String]?
    
    public init(allowedDomains: [String]?) {
        self.allowedDomains = allowedDomains
    }
}

public struct Development: Codable {
    public var debugEnable: Bool?
    
    public init(debugEnable: Bool?) {
        self.debugEnable = debugEnable
    }
}

public struct Custom: Codable {
    
    public var dbs: DBS?
    
    public init(dbs: DBS?) {
        self.dbs = dbs
    }
}

public struct DBS: Codable {
    public var baseURL: String?
    public var gateway: String?
    public var legalEntityInternalId: String?
    public var serviceAgreementId: String?
    public var externalServiceAgreementId: String?
    public var searchIBANURL: String?
    
    public init(baseURL: String?, gateway: String?, legalEntityInternalId: String?, serviceAgreementId: String?, externalServiceAgreementId: String?, searchIBANURL: String?) {
        self.baseURL = baseURL
        self.gateway = gateway
        self.legalEntityInternalId = legalEntityInternalId
        self.serviceAgreementId = serviceAgreementId
        self.externalServiceAgreementId = externalServiceAgreementId
        self.searchIBANURL = searchIBANURL
    }
}

public protocol ConfigurationUseCase {
    func read(environment: Environment, completion: @escaping TCBResponseCompletion<Configuration>)
    func write(environment: Environment, configuration: Configuration, completion: @escaping TCBResponseCompletion<Bool>)
}
