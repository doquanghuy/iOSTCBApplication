//
//  AuditUseCase.swift
//  Domain
//
//  Created by Duong Dinh on 11/16/20.
//

import Foundation

public protocol AuditUseCase {
    func getAuditMessages(username: String, completion:  @escaping TCBResponseCompletion<AuditMessageResponse>)
}
