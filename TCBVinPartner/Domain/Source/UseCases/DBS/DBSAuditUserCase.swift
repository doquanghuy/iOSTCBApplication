//
//  DBSAuditUserCase.swift
//  Domain
//
//  Created by vuong on 11/16/20.
//

import Foundation

public protocol DBSAuditUserCase {
    func getAuditMessages(username: String, completion:  @escaping TCBResponseCompletion<AuditMessageResponse>)
}
