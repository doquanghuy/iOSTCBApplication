//
//  TCBDBSProductSummaryService.swift
//  Domain
//
//  Created by Do Quang Huy on 11/9/20.
//
import ProductsClient
import TCBDomain

public protocol TCBDBSProductSummaryService {
    func fetchProductList(_ completion: @escaping TCBResponseCompletion<[Product]>)
}

class TCBDBSProductSummaryClient {
    private let client: ProductsClient
    
    init() {
        let provider = TCBProductDataProvider(type: .remote(path: "/api"))
        client = ProductsClient(dataProvider: provider)
    }
}

extension TCBDBSProductSummaryClient: TCBDBSProductSummaryService {
    func fetchProductList(_ completion: @escaping TCBResponseCompletion<[Product]>) {
        client.retrieveProductSummary(with: nil) { (productSummary, error) in
            if let productSummary = productSummary {
                let customProductKinds = productSummary.customProductKinds
                var products = [Product]()
                for product in (customProductKinds?.first?.products ?? []) {
                    let res = Product.init(id: product.identifier, accountNumber: product.iban, name: product.name, type: product.productTypeName, amount: product.availableBalance?.doubleValue)
                    products.append(res)
                }
                completion(.success(products))
            } else {
                completion(.error(error!))
            }
        }
    }
}

class TCBProductDataProvider: TCBDataProvider {}

extension ProductsClient: BBAppClient {
    typealias EnvironmentDataProvider = TCBProductDataProvider
}
