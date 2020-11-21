//
//  TCBDataProvider.swift
//  BackbasePlatform
//
//  Created by Son le on 10/9/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import Backbase
import CommonUtils

class TCBDataProvider: NSObject {
    private static let localPath = "assets/backbase/conf/API"
    private static let remoteBaseUrl = URL(string: Backbase.configuration().backbase.serverURL)!

    let providerType: ProviderType

    required init(type: ProviderType) {
        providerType = type
        super.init()
    }

    var baseUrl: URL {
        switch providerType {
        case .local:
            return URL(string: "http://localhost")!
        case let .remote(path, url):
            return url.appendingPathComponent(path)
        }
    }

    var successfulResponse: HTTPURLResponse {
        var url: URL {
            switch providerType {
            case let .local(path):
                return URL(fileURLWithPath: path)
            case let .remote(_, url):
                return url
            }
        }
        return HTTPURLResponse(url: url, statusCode: 200, httpVersion: "1.0", headerFields: nil)!
    }

    func run(request: String, method: HTTPMethod, params: Parameters) -> BehaviourResponseType {
        return .default
    }

    /// Override this method if you need any custom response other than the .json file provided
    func createResponse(from request: String,
                        httpMethod: HTTPMethod,
                        queryItems: QueryItems?,
                        resourceFile: String,
                        body: Data? = nil) -> ProviderResponse {
        let items = queryItems ?? []
        let params = items.reduce(Parameters()) { (result, item) -> Parameters in
            var result = result
            result[item.name] = item.value
            return result
        }

        var type = run(request: request, method: httpMethod, params: params)
        if case .empty = type, httpMethod == .post {
            type = .failed
        }

        return createResponse(resourceFile: resourceFile, for: type)
    }

    func data(for resourceFile: String) -> Data? {
        try? Data(contentsOf: URL(fileURLWithPath: resourceFile))
    }

    public func createResponse(resourceFile: String, for type: BehaviourResponseType) -> ProviderResponse {
        switch type {
        case .empty:
            return .success(successfulResponse, "{}".data(using: .utf8))
        case .failed:
            return .error(URLError.fileNotFound)
        case .noInternet:
            return .error(URLError.notConnectedToInternet)
        case .unauthorized:
            return .error(URLError.unauthorizedAccess)
        case .forbidden:
            return .error(URLError.forbidden)
        case .default:
            guard let data = data(for: resourceFile) else { return .empty }
            return .success(successfulResponse, data)
        }
    }

    /// Use this method to correct the file path based on flags or any other logic
    func correctLocalFilePath(for filePath: String) -> String {
        var resourceFilePath = filePath
        #if RETAILUS
            resourceFilePath = filePath.replacingOccurrences(of: ".json", with: "-us.json")
        #endif
        return resourceFilePath
    }

    func absoluteFilePath(with filePath: String) -> String? {
        return TCBService.bundle.path(forResource: filePath, ofType: ".json")
    }

    static var dbsApiUri: String {
        var path: String {
            guard
                let version = Backbase.configuration().backbase.version,
                let major = version.components(separatedBy: .punctuationCharacters).first,
                let numericMajor = Int(major), numericMajor > 5
                else { return "/services/api" }
            return "/api"
        }
        return path
    }
}

extension TCBDataProvider: DBSDataProvider {
    func execute(_ request: URLRequest, completionHandler: CompletionHandler? = nil) {
        switch providerType {
        case let .local(path):
            executeLocally(request: request, path: path, completionHandler: completionHandler)
        case .remote:
            executeRemotely(request: request, completionHandler: completionHandler)
        }
    }

    func executeLocally(request: URLRequest, path: String, completionHandler: CompletionHandler?) {
        guard
            let method = HTTPMethod(request: request),
            let url = request.url,
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            else {
                completionHandler?(nil, nil, ProviderError.malformedURL)
                return
        }

        // Map the call to the folder structure (which is default behaviour)
        let basePath = URL(fileURLWithPath: path)
        let resourcePath = basePath.appendingPathComponent(components.path)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Simulate a 0.1 second network delay
            guard let resourceFile = self.absoluteFilePath(with: resourcePath.relativeString) else {
                let errorMessage = "** Resource file not found for DataProvider: \(resourcePath.absoluteString).json"
                Backbase.logError(self, message: errorMessage)
                completionHandler?(nil, nil, ProviderError.noResourceFile(message: errorMessage))
                return
            }

            let response = self.createResponse(
                from: components.path,
                httpMethod: method,
                queryItems: components.queryItems,
                resourceFile: resourceFile,
                body: request.httpBody
            )

            switch response {
            case let .success(response, data):
                completionHandler?(response, data, nil)
            case let .error(error):
                completionHandler?(nil, nil, error)
            default:
                completionHandler?(nil, nil, nil)
            }
        }
    }

    /// execute request using remote data provider
    func executeRemotely(request: URLRequest, completionHandler: CompletionHandler?) {
        // Nothing to see here. The remote data provider can just call the actual URL and return the response.
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completionHandler?(response, data, error)
            }
        }.resume()
    }
}

extension TCBDataProvider {
    typealias CompletionHandler = (URLResponse?, Data?, Error?) -> Void
    typealias Parameters = [String: String]
    typealias QueryItems = [URLQueryItem]

    enum ProviderType {
        case local(path: String = TCBDataProvider.localPath)
        case remote(path: String, baseUrl: URL = TCBDataProvider.remoteBaseUrl)
    }

    enum ProviderError: Error {
        case noResourceFile(message: String)
        case noLaunchArguments
        case malformedURL
    }

    enum ProviderResponse {
        case error(Error)
        case success(HTTPURLResponse, Data?)
        case empty
    }
}

extension URLError {
    static let fileNotFound = NSError(domain: NSURLErrorDomain,
                                      code: 404,
                                      userInfo: [NSLocalizedDescriptionKey: "File not found."])

    static let badRequest = NSError(domain: NSURLErrorDomain,
                                    code: 400,
                                    userInfo: [NSLocalizedDescriptionKey: "Bad Request"])

    static let notConnectedToInternet = NSError(domain: NSURLErrorDomain,
                                                code: NSURLErrorNotConnectedToInternet,
                                                userInfo: [NSLocalizedDescriptionKey: "You are not connected to the internet."])

    static let unauthorizedAccess = NSError(domain: NSURLErrorDomain,
                                            code: 401,
                                            userInfo: [NSLocalizedDescriptionKey: "Unauthorized access."])

    static let forbidden = NSError(domain: NSURLErrorDomain,
                                   code: 403,
                                   userInfo: [NSLocalizedDescriptionKey: "Server cannot or will not process the request."])
}

enum BehaviourResponseType: String {
    case `default`
    case noInternet
    case empty
    case failed
    case unauthorized
    case forbidden
}

enum HTTPMethod: String, Codable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"

    init?(request: URLRequest) {
        guard let method = request.httpMethod else { return nil }
        self.init(rawValue: method)
    }
    
    var value: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        case .patch:
            return "PATCH"
        }
    }
}

protocol EnvironmentClient: DBSClient {
    /// Override this property to provide custom implementation for the local client.
    static var local: DBSClient { get }

    /// Override this property to provide custom implementation for the remote client.
    static var remote: DBSClient { get }
}

/// Conform to `BBAppClient` protocol from your clients to enable initializing it using a data provider
/// based on the running environment.
protocol BBAppClient: EnvironmentClient {
    associatedtype EnvironmentDataProvider: TCBDataProvider
    /// Initialize the client with a data provider.
    /// - Parameter dataProvider: `DataProvider` object
    init(dataProvider: EnvironmentDataProvider)
}

extension BBAppClient where Self: BBBaseClient {
    init(dataProvider: EnvironmentDataProvider) {
        self.init()
        baseURL = dataProvider.baseUrl
        self.dataProvider = dataProvider
    }

    static var local: DBSClient {
        let dataProvider = EnvironmentDataProvider(type: .local())
        return Self(dataProvider: dataProvider)
    }

    static var remote: DBSClient {
        let dataProvider = EnvironmentDataProvider(type: .remote(path: TCBDataProvider.dbsApiUri))
        return Self(dataProvider: dataProvider)
    }
}
