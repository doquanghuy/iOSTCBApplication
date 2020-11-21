//
//  TCBProductDataProvider.swift
//  BackbasePlatform
//
//  Created by Son le on 10/9/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import ProductsClient

class TCBProductDataProvider: TCBDataProvider {
    public static var cachedUserPreferences: [String: BBUserPreferencesItem] = [:]

    /*
     * Fix the path for us versions if needed
     */
    public override func data(for resourceFile: String) -> Data? {
        let correctFilePath = correctLocalFilePath(for: resourceFile)
        return try? Data(contentsOf: URL(fileURLWithPath: correctFilePath))
    }

    override var successfulResponse: HTTPURLResponse {
        switch providerType {
        case let .local(path):
            return HTTPURLResponse(url: URL(fileURLWithPath: path), statusCode: 204, httpVersion: "1.0", headerFields: nil)!
        case let .remote(_, url):
            return HTTPURLResponse(url: url, statusCode: 204, httpVersion: "1.0", headerFields: nil)!
        }
    }

    override func createResponse(from request: String,
                                 httpMethod: HTTPMethod,
                                 queryItems: QueryItems?,
                                 resourceFile: String,
                                 body: Data? = nil) -> ProviderResponse {
        let response = super.createResponse(from: request, httpMethod: httpMethod, queryItems: queryItems, resourceFile: resourceFile)

        guard case let .success(_, data) = response,
            let responseData = data else {
                return response
        }

        switch httpMethod {
        case .put:
            return createPUTResponse(from: request, serverResponse: response, data: data, body: body)
        case .get:
            return createGETResponse(from: request, responseData: responseData, queryItems: queryItems)
        default:
            return response
        }
    }

    public override func createResponse(resourceFile: String,
                                        for type: BehaviourResponseType) -> ProviderResponse {
        guard type == .empty else {
            return super.createResponse(resourceFile: resourceFile, for: type)
        }

        var failedPath = (resourceFile as NSString).deletingLastPathComponent
        failedPath = (failedPath as NSString).appendingPathComponent("no-productsummary.json")
        let failedData: Data? = try? Data(contentsOf: URL(fileURLWithPath: failedPath))

        return .success(successfulResponse, failedData)
    }

    func createPUTResponse(from request: String, serverResponse: ProviderResponse, data: Data?, body: Data?) -> ProviderResponse {
        if request.hasSuffix("user-preferences") {
            if let body = body {
                do {
                    let userPreferences = try JSONSerialization.jsonObject(with: body, options: .allowFragments)
                    let userPreferenceItem = try BBUserPreferencesItem.map(userPreferences)
                    TCBProductDataProvider.cachedUserPreferences[userPreferenceItem.arrangementId] = userPreferenceItem
                } catch {
                    return .success(successfulResponse, data)
                }
            }
        }
        return .success(successfulResponse, data)
    }

    func createGETResponse(from request: String, responseData: Data, queryItems: QueryItems?) -> ProviderResponse {
        if request.hasSuffix("productsummary") {
            let productsResponse = ProductsGETResponse(with: TCBProductDataProvider.cachedUserPreferences)
            let newData = productsResponse.changeUserPreferences(for: responseData)
            return .success(successfulResponse, newData)
        }
        return .success(successfulResponse, responseData)
    }

    /*
     * Normally, empty data would be an empty array or dictionary, but for product summary it should contain
     * the aggregated balance, so we force it here.
     */
    func retrieveCustomEmptyData(from filePath: String) -> Data? {
        guard let resourceFile = TCBService.bundle.path(forResource: filePath, ofType: ".json") else {
            let errorMessage = "** Resource file not found for DataProvider: \(filePath).json"
            Backbase.logError(self, message: errorMessage)
            return nil
        }
        return try? Data(contentsOf: URL(fileURLWithPath: resourceFile))
    }
}

private struct ProductsResponseConstants {
    static let products = "products"
    static let id = "id"
    static let userPreferences = "userPreferences"
}

struct ProductsGETResponse {
    var cachedPreferences: [String: BBUserPreferencesItem]

    init(with cachedPreferences: [String: BBUserPreferencesItem]) {
        self.cachedPreferences = cachedPreferences
    }

    func changeUserPreferences(for data: Data) -> Data {
        guard !cachedPreferences.isEmpty else {
            return data
        }
        do {
            if var objects = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                for (key, value) in objects {
                    if var value = value as? [String: Any],
                        let products = value[ProductsResponseConstants.products] as? [Any] {
                        value[ProductsResponseConstants.products] = handleProducts(products: products)
                        objects[key] = value
                    }
                }
                return try JSONSerialization.data(withJSONObject: objects, options: .fragmentsAllowed)
            }
        } catch {
            Backbase.logError(self, message: error.localizedDescription)
        }

        return data
    }

    private func handleProducts(products: [Any]) -> [Any] {
        var products = products

        for i in 0 ..< products.count {
            if var product = products[i] as? [String: Any],
                let productIdentifier = product[ProductsResponseConstants.id] as? String {
                if cachedPreferences.keys.contains(productIdentifier),
                    let cachedPreference = cachedPreferences[productIdentifier] {
                    product[ProductsResponseConstants.userPreferences] = cachedPreference.jsonPayload()
                    products[i] = product
                }
            }
        }
        return products
    }
}
