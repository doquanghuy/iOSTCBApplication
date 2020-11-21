//
//  TCBDBSClient.swift
//  TCBService
//
//  Created by Huy Van Nguyen on 11/5/20.
//

import TCBDomain
import Backbase

class TCBDBSClient: NSObject {
    
    private var host: String {
        return Backbase.dbsBaseURL
    }
    
    private var gateway: String {
        return Backbase.dbsGateway
    }
    
    private var importIdentityUserToDBSPath: String {
        return "/user-manager/service-api/v2/users/identities"
    }
    
    private var loginPath: String {
        return "/gateway/api/auth/login"
    }
    
    private var getProductSummaryPath: String {
        return "/gateway/api/product-summary-presentation-service/v2/productsummary"
    }
    
    private var addUserAsSAAdminPath: String {
        return "/accessgroup-integration-service/v2/accessgroups/serviceagreements/admins/add"
    }
    
    private var createArrangementPath: String {
        return "/arrangement-manager/integration-api/v2/arrangements"
    }
    
    private var createFunctionGroupsPath: String {
        return "/accessgroup-integration-service/v2/accessgroups/function-groups"
    }
    
    private func assignPermissionPath(serviceAgreementId: String, userInternalId: String) -> String {
        return "/access-control/client-api/v2/accessgroups/service-agreements/\(serviceAgreementId)/users/\(userInternalId)/permissions"
    }
    
    private var createDataGroupPath: String {
        return "/access-control/client-api/v2/accessgroups/data-groups"
    }
    
    private var setUserContextPath: String {
        return "/access-control/client-api/v2/accessgroups/usercontext"
    }
    
    //
    // {{host}}:8092/audit-service/service-api/v3/audit-log/messages
    private var getAuditMessages: String {
        return "/audit-service/service-api/v3/audit-log/messages"
    }
    
}

extension TCBDBSClient: TCBDBSService {
    func getAuditMessages(request: TCBAuditMessagesRequest, completion: @escaping (TCBResult<AuditMessageResponse>) -> ()) {
    
        let port = host.components(separatedBy: ":").last ?? ""
        let urlHost = host.replacingOccurrences(of: port, with: "8092")
        let urlString = urlHost + getAuditMessages
        
        var request = URLRequest(url: URL(string: "http://18.139.127.103:8092/audit-service/service-api/v3/audit-log/messages?partialMatchAgainst=\(request.partialMatchAgainst)&orderBy=\(request.orderBy)&direction=\(request.direction)&usernames=\(request.username)")!,timeoutInterval: Double.infinity)
        
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            Logger.log([(key: "url", value: urlString), (key: "parameters", value: request), (key: "data", value: data), (key: "response", value: response), (key: "error", value: error)])
            
            if let error = error {
                // Handle    HTTP request error
                completion(.failure(error))
            }  else if let data = data {
                // Handle HTTP request response
                do {
                    let jsonData = try JSONDecoder().decode(AuditMessageResponse.self, from: data)
                    completion(.success(jsonData))
                    
                } catch let error {
                    completion(.failure((error)))
                }
            } else {
                // Handle unexpected error
                completion(.failure(APIError.unknown))
            }
        }
        
        task.resume()
        
    }
    
    func importIdentityUserToDBS(request: TCBImportIdentityUserToDBSRequest, completion: @escaping (TCBResult<TCBImportIdentityUserToDBSResponse>) -> ()) {
        
        let urlString = host + importIdentityUserToDBSPath
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.urlError))
            return
        }
        
        let parameters = "{\n  \"externalId\": \"\(request.externalId)\",\n  \"legalEntityInternalId\": \"\(request.legalEntityInternalId)\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            Logger.log([(key: "url", value: urlString), (key: "parameters", value: parameters), (key: "data", value: data), (key: "response", value: response), (key: "error", value: error)])
            
            if let error = error {
                // Handle HTTP request error
                completion(.failure(error))
            }  else if let data = data {
                // Handle HTTP request response
                do {
                    let jsonData = try JSONDecoder().decode(TCBImportIdentityUserToDBSResponse.self, from: data)
                    if let message = jsonData.message {
                        completion(.failure(APIError.errorMessage(message)))
                    } else {
                        completion(.success(jsonData))
                    }
                } catch let error {
                    completion(.failure((error)))
                }
            } else {
                // Handle unexpected error
                completion(.failure(APIError.unknown))
            }
        }
        
        task.resume()
    }
    
    func addUserAsSAAdmin(request: TCBAddUserAsSAAdminRequest, completion: @escaping (TCBResult<TCBAddUserAsSAAdminResponse>) -> ()) {
        
        let urlString = host + addUserAsSAAdminPath
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.urlError))
            return
        }
        
        let parameters = "[\n  {\n    \"externalUserId\": \"\(request.externalUserId)\",\n    \"externalServiceAgreementId\": \"\(request.externalServiceAgreementId)\"\n  }\n]"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            Logger.log([(key: "url", value: urlString), (key: "parameters", value: parameters), (key: "data", value: data), (key: "response", value: response), (key: "error", value: error)])
            
            if let error = error {
                // Handle HTTP request error
                completion(.failure(error))
            }  else if let data = data {
                // Handle HTTP request response
                do {
                    let jsonData = try JSONDecoder().decode([TCBAddUserAsSAAdminResponse].self, from: data)
                    if let obj = jsonData.first {
                        if let status = obj.status, status == "200" {
                            completion(.success(obj))
                        } else {
                            if let errors = obj.errors, let message = errors.first {
                                completion(.failure(APIError.errorMessage(message)))
                            } else {
                                completion(.failure(APIError.unknown))
                            }
                        }
                    } else {
                        completion(.failure(APIError.unknown))
                    }
                } catch let error {
                    completion(.failure((error)))
                }
            } else {
                // Handle unexpected error
                completion(.failure(APIError.unknown))
            }
        }
        
        task.resume()
    }
    
    func requestCreateArrangement(request: TCBCreateArrangementRequest, completion: @escaping (TCBResult<TCBCreateArrangementResponse>) -> ()) {
        
        let urlString = gateway + createArrangementPath
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.urlError))
            return
        }
        
        let parameters = "{\n    \"id\": \"\(request.id)\",\n    \"name\": \"\(request.name)\",\n    \"IBAN\": \"\(request.IBAN)\",\n    \"bookedBalance\": \(request.bookedBalance),\n    \"availableBalance\": \(request.availableBalance),\n    \"creditLimit\": \(request.creditLimit),\n    \"legalEntityIds\": [\n        \"Techcombank\"\n    ],\n    \"productId\": \"\(request.productId)\",\n    \"alias\": \"\(request.alias)\",\n    \"BBAN\": \"\(request.BBAN)\",\n    \"currency\": \"\(request.currency)\",\n    \"externalTransferAllowed\": \(request.externalTransferAllowed),\n    \"urgentTransferAllowed\": \(request.urgentTransferAllowed),\n    \"accruedInterest\": \(request.accruedInterest),\n    \"number\": \"\(request.number)\",\n    \"principalAmount\": \(request.principalAmount),\n    \"currentInvestmentValue\": \(request.currentInvestmentValue),\n    \"BIC\": \"\(request.BIC)\",\n    \"bankBranchCode\": \"\(request.bankBranchCode)\"\n}"
        let postData = parameters.data(using: .utf8)
        
        guard let accessToken = TCBSessionManager.shared.getAccessTokenUser() else {
            completion(.failure(APIError.tokenExpired))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            Logger.log([(key: "url", value: urlString), (key: "parameters", value: parameters), (key: "data", value: data), (key: "response", value: response), (key: "error", value: error)])
            
            if let response = response as? HTTPURLResponse, let statusCode = HTTPStatusCode(rawValue: response.statusCode), statusCode == HTTPStatusCode.unauthorized {
                TCBSessionManager.shared.setAccessToken("duc", nil)
                TCBSessionManager.shared.setRefreshToken("duc", nil)
                completion(.failure(APIError.tokenExpired))
            } else if let error = error {
                // Handle HTTP request error
                completion(.failure(error))
            }  else if let data = data {
                // Handle HTTP request response
                do {
                    let jsonData = try JSONDecoder().decode(TCBCreateArrangementResponse.self, from: data)
                    if let message = jsonData.message {
                        completion(.failure(APIError.errorMessage(message)))
                    } else {
                        completion(.success(jsonData))
                    }
                } catch let error {
                    completion(.failure((error)))
                }
            } else {
                // Handle unexpected error
                completion(.failure(APIError.unknown))
            }
            
        }
        
        task.resume()
    }
    
    func createMobileTransactionSalaryArrangements(request: TCBMobileTransactionSalaryArrangementsRequest, completion: @escaping (TCBResult<[String]>) -> ()) {
                var items: [String?] = []
                var storeError4: Error?
                let money: Double = 10_000_000
                let idPayment = "\(request.username) account"
                let namePayment = "\(request.username) Account"
                let paymentArrangementRequest = TCBCreateArrangementRequest(id: idPayment, name: namePayment, IBAN: Backbase.iban, bookedBalance: money, availableBalance: money, creditLimit: money, productId: "tcb001")
                let dispatchGroup = DispatchGroup()
                dispatchGroup.enter()
                requestCreateArrangement(request: paymentArrangementRequest) { (response) in
                    switch response {
                    case .success(let data):
                        items.append(data.arrangementId)
                    case .failure(let error):
                        storeError4 = error
                    }
                    // 6a
                    dispatchGroup.leave()
                }
                
                dispatchGroup.notify(queue: DispatchQueue.main) {
                    let items = items.compactMap { $0 }
                    if items.count > 0 {
                        completion(.success(items))
                    } else {
                        completion(.failure(APIError.unknown))
                    }
                }
    }
    
    func createArrangement(request: TCBCreateArrangementRequest, completion: @escaping (TCBResult<TCBCreateArrangementResponse>) -> ()) {
                requestCreateArrangement(request: request) { (response) in
                    switch response {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    func createFunctionGroups(request: TCBCreateFunctionGroupsRequest, completion: @escaping (TCBResult<TCBCreateFunctionGroupsResponse>) -> ()) {
        
        let urlString = host + createFunctionGroupsPath
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.urlError))
            return
        }
        
        let parameters = getParam(name: request.name, description: request.description, externalServiceAgreementId: request.externalServiceAgreementId)
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            Logger.log([(key: "url", value: urlString), (key: "parameters", value: parameters), (key: "data", value: data), (key: "response", value: response), (key: "error", value: error)])
            
            if let error = error {
                // Handle HTTP request error
                completion(.failure(error))
            }  else if let data = data {
                // Handle HTTP request response
                do {
                    let jsonData = try JSONDecoder().decode(TCBCreateFunctionGroupsResponse.self, from: data)
                    if let message = jsonData.message {
                        completion(.failure(APIError.errorMessage(message)))
                    } else {
                        completion(.success(jsonData))
                    }
                } catch let error {
                    completion(.failure((error)))
                }
            } else {
                // Handle unexpected error
                completion(.failure(APIError.unknown))
            }
            
        }
        
        task.resume()
    }
    
    func requestAssignPermission(request: TCBAssignPermissionRequest, completion: @escaping (TCBResult<TCBAssignPermissionResponse>) -> ()) {
        
        let urlString = gateway + assignPermissionPath(serviceAgreementId: Backbase.dbsServiceAgreementId, userInternalId: request.userInternalId)
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.urlError))
            return
        }
        
        let parameters = "{\n    \"items\": [\n        {\n            \"functionGroupId\": \"\(request.functionGroupId)\",\n            \"dataGroupIds\": [\n                {\n                    \"id\": \"\(request.dataGroupId)\"\n                }\n            ]\n        }\n    ]\n}"
        let postData = parameters.data(using: .utf8)
        
        guard let accessToken = TCBSessionManager.shared.getAccessTokenUser() else {
            completion(.failure(APIError.tokenExpired))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "PUT"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            Logger.log([(key: "url", value: urlString), (key: "parameters", value: parameters), (key: "data", value: data), (key: "response", value: response), (key: "error", value: error)])
            
            if let response = response as? HTTPURLResponse, let statusCode = HTTPStatusCode(rawValue: response.statusCode), statusCode == HTTPStatusCode.unauthorized {
                TCBSessionManager.shared.setAccessToken("duc", nil)
                TCBSessionManager.shared.setRefreshToken("duc", nil)
                completion(.failure(APIError.tokenExpired))
            } else if let error = error {
                // Handle HTTP request error
                completion(.failure(error))
            }  else if let data = data {
                // Handle HTTP request response
                do {
                    let jsonData = try JSONDecoder().decode(TCBAssignPermissionResponse.self, from: data)
                    if let message = jsonData.message {
                        completion(.failure(APIError.errorMessage(message)))
                    } else {
                        completion(.success(TCBAssignPermissionResponse()))
                    }
                } catch let error {
                    completion(.failure((error)))
                }
            } else {
                // Handle unexpected error
                completion(.failure(APIError.unknown))
            }
        }
        
        task.resume()
    }
    
    func assignPermission(request: TCBAssignPermissionRequest, completion: @escaping (TCBResult<TCBAssignPermissionResponse>) -> ()) {
                requestAssignPermission(request: request) { (response) in
                    switch response {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    func requestCreateDataGroup(request: TCBCreateDataGroupRequest, completion: @escaping (TCBResult<TCBCreateDataGroupResponse>) -> ()) {
        
        let urlString = gateway + createDataGroupPath
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.urlError))
            return
        }
        
        let items = request.items
        if items.count < 1 {
            completion(.failure(APIError.unknown))
        }
        let paymentItem = items[0]
        let parameters = "{\n  \"name\": \"\(request.name)\",\n  \"description\": \"\(request.description)\",\n  \"serviceAgreementId\": \"\(request.serviceAgreementId)\",\n  \"type\": \"ARRANGEMENTS\",\n  \"items\": [\n    \"\(paymentItem)\"\n ]\n}"
        let postData = parameters.data(using: .utf8)
        
        guard let accessToken = TCBSessionManager.shared.getAccessTokenUser() else {
            completion(.failure(APIError.tokenExpired))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            Logger.log([(key: "url", value: urlString), (key: "parameters", value: parameters), (key: "data", value: data), (key: "response", value: response), (key: "error", value: error)])
            
            if let response = response as? HTTPURLResponse, let statusCode = HTTPStatusCode(rawValue: response.statusCode), statusCode == HTTPStatusCode.unauthorized {
                TCBSessionManager.shared.setAccessToken("duc", nil)
                TCBSessionManager.shared.setRefreshToken("duc", nil)
                completion(.failure(APIError.tokenExpired))
            } else if let error = error {
                // Handle HTTP request error
                completion(.failure(error))
            }  else if let data = data {
                // Handle HTTP request response
                do {
                    let jsonData = try JSONDecoder().decode(TCBCreateDataGroupResponse.self, from: data)
                    if let message = jsonData.message {
                        completion(.failure(APIError.errorMessage(message)))
                    } else {
                        completion(.success(jsonData))
                    }
                } catch let error {
                    completion(.failure((error)))
                }
            } else {
                // Handle unexpected error
                completion(.failure(APIError.unknown))
            }
        }
        
        task.resume()
    }
    
    func createDataGroup(request: TCBCreateDataGroupRequest, completion: @escaping (TCBResult<TCBCreateDataGroupResponse>) -> ()) {
                requestCreateDataGroup(request: request) { (response) in
                    switch response {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
}
