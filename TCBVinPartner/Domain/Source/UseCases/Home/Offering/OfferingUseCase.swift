//
//  OfferingUseCase.swift
//  Domain
//
//  Created by vuong on 10/16/20.
//

import Foundation

public protocol OfferingUseCase {
    func retrieveOfferings(completion: TCBResponseCompletion<Offering>)
}
