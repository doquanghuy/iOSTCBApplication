//
//  MessagesUseCase.swift
//  Domain
//
//  Created by duc on 10/19/20.
//

import Foundation

public protocol MessagesUseCase {
    func fetchMessages(completion: @escaping TCBResponseCompletion<[Message]>)
}

