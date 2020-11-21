//
//  FirebaseUseCase.swift
//  Alamofire
//
//  Created by Pham Thanh Hoa on 11/13/20.
//

import Foundation

public protocol FirebaseUseCase {
    func sendPaymentNotification(userId: String,
                                 completion: @escaping TCBResponseCompletion<FirebaseMessage>)
}

public struct FirebaseMessage: Codable {
    public let messageId: Int64
    
    public init(messageId: Int64) {
        self.messageId = messageId
    }
}
