//
//  TCBProductSummaryUseCase.swift
//  TCBService
//
//  Created by Do Quang Huy on 11/9/20.
//

import Foundation
import TCBDomain

class TCBProductSummaryUseCase: ProductUseCase {
    private let client: TCBDBSProductSummaryService

    init(client: TCBDBSProductSummaryService) {
        self.client = client
    }

    func getProducts(completion: @escaping TCBResponseCompletion<[Product]>) {
        client.fetchProductList(completion)
    }
}
