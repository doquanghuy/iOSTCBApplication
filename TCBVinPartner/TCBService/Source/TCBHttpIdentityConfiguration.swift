//
//  TCBIdentityConfiguration.swift
//  TCBService
//
//  Created by vuong on 10/30/20.
//

import Foundation

protocol TCBHttpIdentityConfigurationProtocol {
    var bruteForceProtected: Bool? { get set }
    var waitIncrementSeconds: UInt? { get set}
    var failureFactor: Int? { get set } // Max number failure login.
}

struct TCBHttpIdentityConfiguration: TCBHttpIdentityConfigurationProtocol {
    var bruteForceProtected: Bool?
    var waitIncrementSeconds: UInt?
    var failureFactor: Int?
    
    init(bruteForceProtected: Bool?, waitIncrementSeconds: UInt?, failureFactor: Int?) {
        self.bruteForceProtected = bruteForceProtected
        self.waitIncrementSeconds = waitIncrementSeconds
        self.failureFactor = failureFactor
    }
    
    enum CodingKeys: String, CodingKey {
        case bruteForceProtected = "bruteForceProtected"
        case waitIncrementSeconds = "waitIncrementSeconds"
        case failureFactor = "failureFactor"
    }
}
