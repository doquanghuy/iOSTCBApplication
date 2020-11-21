//
//  DBSUseCase.swift
//  Domain
//
//  Created by Huy Van Nguyen on 11/5/20.
//

import Foundation

public protocol DBSUseCase {
    func importIdentityUserToDBS(with username: String, completion: @escaping TCBResponseCompletion<TCBImportIdentityUserToDBSResponse>)
}

public struct TCBImportIdentityUserToDBSResponse: Codable {
    
    public var internalId: String?
    public var externalId: String?
    
    public var message: String?
    public var errors: [Errors]?
    
    public init(internalId: String?, externalId: String?, message: String?, errors: [Errors]?) {
        self.internalId = internalId
        self.externalId = externalId
        self.message = message
        self.errors = errors
    }
    
    public struct Errors: Codable {
        public var message: String?
        public var key: String?
        public var context: Context?
        
        public init(message: String?, key: String?, context: Context?) {
            self.message = message
            self.key = key
            self.context = context
        }
    }
    
    public struct Context: Codable {
        public init() {
        }
    }
}
