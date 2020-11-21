//
//  TCBService.swift
//  TCBService
//
//  Created by Son le on 10/8/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Backbase
import TCBDomain
import AccessControlClient
import UserProfileClient

public enum TCBServiceAuth {
    case identity
    case httpIdentity
}

extension Environment {

    var configFilePath: String? {
        let bundle = TCBService.bundle
        switch self {
        case .local:
            return bundle.path(forResource: "assets/backbase/conf/config-local", ofType: ".json")
        case .aws:
            return bundle.path(forResource: "assets/backbase/conf/config-aws", ofType: ".json")
        }
    }
}

// MARK: - Have to initialize in AppDelegate befure using any Client Object
public class TCBService {
    public class func initialize(enviroment: Environment, auth: TCBServiceAuth) throws {
        // copy file config from main bundle to documents/library folder if need
        copyFileConfigFromMainBundleToDocumentIfNeed()
        
//        let configFileURL = URL(fileURLWithPath: configFilePath)
        guard let documentsUrl: URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let destinationFileUrl = documentsUrl.appendingPathComponent(enviroment.fileName)
        try Backbase.initialize(from: destinationFileUrl, forceDecryption: false)
        
        let authClient = buildAuthClient(type: auth)
        Backbase.register(authClient: authClient)

        TCBServiceFactory.initializeServices()
        
        let accessControlDataProvider = AccessControlDataProvider(type: .remote(path: "/api"))
        try Backbase.register(client: AccessControlClient(dataProvider: accessControlDataProvider))
    }

    public class var bundle: Bundle {
        return Bundle(for: self)
    }
    
    private class func copyFileConfigFromMainBundleToDocumentIfNeed() {
        for environment in Environment.allCases {
            if !checkFileExist(environment) {
                copyFileToDocument(environment)
            }
        }
    }
    
    private class func checkFileExist(_ environment: Environment) -> Bool {
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            let fileURL = documentsDirectory.appendingPathComponent(environment.fileName)
           do {
               if try fileURL.checkResourceIsReachable() {
                    print("file exist")
               } else {
                    print("file doesnt exist")
                    return false
               }
           } catch {
                print("an error happened while checking for the file")
                return false
           }
        }
        return true
    }
    
    private class func copyFileToDocument(_ environment: Environment) {
        guard let configFilePath = environment.configFilePath else {
            return
        }
        let from = URL(fileURLWithPath: configFilePath)

        let to = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(environment.fileName)

        do {

            try FileManager.default.copyItem(at: from, to: to)

        } catch {
            print(error)
        }
    }
}

private extension TCBService {
    class func buildAuthClient(type: TCBServiceAuth) -> AuthClient {
        switch type {
        case .identity:
            guard Backbase.configuration().backbase.identity != nil else {
                fatalError("Missing Backbase Identity configuration")
            }
            return TCBIdentityAuthClient(clientSecret:"")
        case .httpIdentity:
            return TCBHTTPIdentityAuthClient()
        }
    }
}

public enum TCBResult<Value> {
    case success(Value)
    case failure(Error)

    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }

    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }

    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

extension TCBDomain.TCBResult {
    static func from(_ result: TCBResult<T>) -> TCBDomain.TCBResult<T> {
        switch result {
        case .success(let value):
            return .success(value)
        case .failure(let error):
            return .error(error)
        }
    }
}
