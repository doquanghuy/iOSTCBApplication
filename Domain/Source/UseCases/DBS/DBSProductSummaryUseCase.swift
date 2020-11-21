//
//  DBSProductSummaryUseCase.swift
//  Domain
//
//  Created by Do Quang Huy on 11/9/20.
//

import Foundation

public protocol ProductUseCase {
    func getProducts(completion: @escaping TCBResponseCompletion<[Product]>)
}
