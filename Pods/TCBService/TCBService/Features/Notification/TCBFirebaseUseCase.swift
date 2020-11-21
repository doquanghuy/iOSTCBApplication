//
//  TCBFirebaseUseCase.swift
//  Alamofire
//
//  Created by Pham Thanh Hoa on 11/13/20.
//

import Foundation
import TCBDomain

class TCBFirebaseUseCase: FirebaseUseCase {
    private let client = TCBFirebaseClient()
    
    func sendPaymentNotification(userId: String,
                                 completion: @escaping TCBResponseCompletion<FirebaseMessage>) {
        client.sendPaymentNotification(userId: userId, completion: completion)
    }
}
