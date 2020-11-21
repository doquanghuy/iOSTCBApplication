//
//  TCBProductClient.swift
//  BackbasePlatform
//
//  Created by Son le on 10/9/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import ProductsClient

// MARK: - Initialize - public functions
public protocol TCBProductService {
    func fetchProducts(_ completion: @escaping ([TCBProductModel], Error?) -> Void)
    func fetchBalance(_ completion: @escaping (String?, Error?) -> ())
}

class TCBProductClient {
    private let client: ProductsClient
    
    init() {
        let provider = TCBProductDataProvider(type: .local())
        client = ProductsClient(dataProvider: provider)
    }
}

extension TCBProductClient: TCBProductService {
    func fetchProducts(_ completion: @escaping ([TCBProductModel], Error?) -> Void) {
        client.retrieveProductSummary(with: nil) { (productSummary, error) in
            if let productSummary = productSummary {
                let convertedData = self.convertData(from: productSummary)
                completion(convertedData, error)
            } else {
                completion([], error)
            }
        }
    }

    func fetchBalance(_ completion: @escaping (String?, Error?) -> ()) {
        fetchProducts { products, error in
            if let balance = products.first?.aggregatedBalance {
                completion(balance, error)
            } else {
                completion(nil, error)
            }
        }
    }
}

// MARK: - Private functions & converter
extension TCBProductClient {
    private func convertData(from summary: BBProductSummary) -> [TCBProductModel] {
        let productFormatter = ProductsFormatter()
        let productsKind = summary.filteredProductsKinds
        let utils = AccountSummaryUtils()

        let convertedList = productsKind.compactMap({ productKind -> TCBProductModel in
            let accounts = productKind.filteredProducts.compactMap({ utils.formattedAccountSummary(for: $0) })
            let newModel = TCBProductModel(name: localizedProductKindsName(for: type(of: productKind)),
                                           aggregatedBalance: productFormatter.total(for: productKind) ?? "",
                                           accounts: accounts)
            return newModel
        })
        return convertedList
    }

    private func localizedProductKindsName(for kClass: AnyClass) -> String {
        switch kClass {
        case is BBCurrentAccounts.Type, is BBCurrentAccount.Type:
            return "Current Accounts"
        case is BBSavingsAccounts.Type, is BBSavingsAccount.Type:
            return "Savings Accounts"
        case is BBTermDeposits.Type, is BBTermDeposit.Type:
            return "Term Deposits"
        case is BBCreditCards.Type, is BBCreditCard.Type:
            return "Credit Cards"
        case is BBDebitCards.Type, is BBDebitCard.Type:
            return "Debit Cards"
        case is BBLoans.Type, is BBLoan.Type:
            return "Loans"
        case is BBInvestmentAccounts.Type, is BBInvestmentAccount.Type:
            return "Investment Accounts"
        default:
            return ""
        }
    }
}

// MARK: - Backbase ProductsClient class extension
extension ProductsClient: BBAppClient {
    typealias EnvironmentDataProvider = TCBProductDataProvider

    private convenience init(dataProvider: TCBDataProvider, factory: BBProductConverterFactory) {
        self.init(productConverterFactory: factory)
        baseURL = dataProvider.baseUrl
        self.dataProvider = dataProvider
    }

    static var local: DBSClient {
        let dataProvider = EnvironmentDataProvider(type: .local())
        let factory = BBProductConverterFactory(mapping: ProductsFormatter.convertersMapping)
        return ProductsClient(dataProvider: dataProvider, factory: factory)
    }

    static var remote: DBSClient {
        let dataProvider = EnvironmentDataProvider(type: .remote(path: TCBDataProvider.dbsApiUri))
        let factory = BBProductConverterFactory(mapping: ProductsFormatter.convertersMapping)
        return ProductsClient(dataProvider: dataProvider, factory: factory)
    }
}

extension BBProductSummary {
    var filteredProductsKinds: [BBProductKind] {
        return productKinds().filter { $0.countFilteredProducts > 0 }
    }
}

public extension BBProductKind {
    var filteredProducts: [BBBaseProduct] {
        return (products ?? []).filter { $0.isVisible }
    }

    fileprivate var countFilteredProducts: Int {
        return filteredProducts.count
    }
}

extension BBBaseProduct {
    var isVisible: Bool {
        return userPreferences?.visible?.boolValue ?? true
    }

    var productName: String {
        return userPreferences?.alias ?? name ?? ""
    }
}
