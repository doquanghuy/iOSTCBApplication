//
//  TCBDBSClient.swift
//  TCBService
//
//  Created by Huy Van Nguyen on 11/5/20.
//

import Domain
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
    
//    func getAccessTokenDBS(completion: @escaping ((Bool) -> Void)) {
//        if TCBSessionManager.shared.getAccessTokenDBS() == nil {
//            let httpIdentityAuthClient = TCBHTTPIdentityAuthClient()
//            httpIdentityAuthClient.dbsLogin() { [weak self] (result) in
//                switch result {
//                case .success(let data):
//                    if data {
//                        self?.setUserContext { (response) in
//                            switch response {
//                            case .success(let status):
//                                completion(status)
//                            case .failure(let error):
//                                completion(false)
//                            }
//                        }
//                    } else {
//                        completion(false)
//                    }
//                case .failure(let error):
//                    completion(false)
//                }
//            }
//        } else {
//            completion(true)
//        }
//    }
//
//    func setUserContext(completion: @escaping (TCBResult<Bool>) -> ()) {
//        let urlString = gateway + setUserContextPath
//        guard let url = URL(string: urlString) else {
//            completion(.failure(APIError.urlError))
//            return
//        }
//        let parameters = "{\n  \"serviceAgreementId\": \"\(Backbase.dbsServiceAgreementId)\"\n}"
//        let postData = parameters.data(using: .utf8)
//
//        guard let accessToken = TCBSessionManager.shared.getAccessTokenDBS() else {
//            completion(.failure(APIError.tokenExpired))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        request.httpMethod = "POST"
//        request.httpBody = postData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let response = response as? HTTPURLResponse, let statusCode = HTTPStatusCode(rawValue: response.statusCode)?.responseType, statusCode == HTTPStatusCode.ResponseType.success {
//                completion(.success(true))
//            } else {
//                completion(.success(false))
//            }
//        }
//
//        task.resume()
//    }
    
    func getAuditMessages(request: TCBAuditMessagesRequest, completion: @escaping (TCBResult<AuditMessageResponse>) -> ()) {
    
        let port = host.components(separatedBy: ":").last ?? ""
        let urlHost = host.replacingOccurrences(of: port, with: "8092")
        let urlString = urlHost + getAuditMessages
        
        var request = URLRequest(url: URL(string: "http://18.139.127.103:8092/audit-service/service-api/v3/audit-log/messages?partialMatchAgainst=\(request.partialMatchAgainst)&orderBy=\(request.orderBy)&direction=\(request.direction)&usernames=\(request.username)")!,timeoutInterval: Double.infinity)
        
        request.httpMethod = "GET"
        
        /*
        guard let accessToken = TCBSessionManager.shared.getAccessTokenUser() else {
            completion(.failure(APIError.tokenExpired))
            return
        }
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        */
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
        
//        getAccessTokenDBS { [weak self] (result) in
//            if result {
            
                var items: [String?] = []
//                var storeError1: Error?
//                var storeError2: Error?
//                var storeError3: Error?
                var storeError4: Error?
                
                let money: Double = 10_000_000
//                let mobileArrangementRequest = TCBCreateArrangementRequest(id: Backbase.dbsRandomString, name: Backbase.dbsRandomString, IBAN: Backbase.iban, bookedBalance: money, availableBalance: money, creditLimit: money, productId: "tcb001")
//
//                let salaryArrangementRequest = TCBCreateArrangementRequest(id: Backbase.dbsRandomString, name: Backbase.dbsRandomString, IBAN: Backbase.iban, bookedBalance: money, availableBalance: money, creditLimit: money, productId: "tcb002")
                
                let idPayment = "\(request.username) account"
                let namePayment = "\(request.username) Account"
                let paymentArrangementRequest = TCBCreateArrangementRequest(id: idPayment, name: namePayment, IBAN: Backbase.iban, bookedBalance: money, availableBalance: money, creditLimit: money, productId: "tcb001")
                
                
                // 2
                let dispatchGroup = DispatchGroup()
                
//                // 3
//                dispatchGroup.enter()
//
//                self?.requestCreateArrangement(request: mobileArrangementRequest) { (response) in
//                    switch response {
//                    case .success(let data):
//                        items.append(data.arrangementId)
//                    case .failure(let error):
//                        storeError1 = error
//
//                    }
//                    // 5a
//                    dispatchGroup.leave()
//                }

                

//                // 4
//                dispatchGroup.enter()
//                self?.requestCreateArrangement(request: salaryArrangementRequest) { (response) in
//                    switch response {
//                    case .success(let data):
//                        items.append(data.arrangementId)
//                    case .failure(let error):
//                        storeError2 = error
//
//                    }
//                    // 5a
//                    dispatchGroup.leave()
//                }
                
//                // 6
//                dispatchGroup.enter()
//                self?.requestCreateArrangement(request: transactionArrangementRequest) { (response) in
//                    switch response {
//                    case .success(let data):
//                        items.append(data.arrangementId)
//                    case .failure(let error):
//                        storeError3 = error
//
//                    }
//                    // 6a
//                    dispatchGroup.leave()
//                }
                
                // 6
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
//            } else {
//                completion(.failure(APIError.tokenExpired))
//            }
//        }
    }
    
    func createArrangement(request: TCBCreateArrangementRequest, completion: @escaping (TCBResult<TCBCreateArrangementResponse>) -> ()) {
        
//        getAccessTokenDBS { [weak self] (result) in
//            if result {
                
                requestCreateArrangement(request: request) { (response) in
                    switch response {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
//            } else {
//                completion(.failure(APIError.tokenExpired))
//            }
//        }
    }
    
    func createFunctionGroups(request: TCBCreateFunctionGroupsRequest, completion: @escaping (TCBResult<TCBCreateFunctionGroupsResponse>) -> ()) {
        
        let urlString = host + createFunctionGroupsPath
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.urlError))
            return
        }
        
        let parameters = "{\n    \"name\": \"\(request.name)\",\n    \"description\": \"\(request.description)\",\n    \"externalServiceAgreementId\": \"\(request.externalServiceAgreementId)\",\n    \"permissions\": [\n        {\n            \"functionId\": \"1070\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1026\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"execute\"\n                },\n                {\n                    \"privilege\": \"view\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1013\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1043\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1068\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1032\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1050\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1049\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1072\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1009\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1037\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1078\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1076\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"execute\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1010\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1059\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1073\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1075\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"execute\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1019\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1015\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1028\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1044\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1052\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1045\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1031\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"execute\"\n                },\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1053\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1042\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1034\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1047\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1033\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1003\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1035\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1039\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1005\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1041\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1061\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1071\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1016\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1048\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1018\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1024\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"execute\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1006\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1046\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1040\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1021\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1011\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1051\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1066\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1063\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1014\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1069\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1017\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1055\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"execute\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1022\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1025\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1065\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1060\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1038\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1002\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1056\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1023\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1057\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1074\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1058\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1064\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"execute\"\n                },\n                {\n                    \"privilege\": \"view\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1062\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"execute\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1012\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1077\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1054\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1029\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"execute\"\n                },\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1027\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"execute\"\n                },\n                {\n                    \"privilege\": \"view\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1030\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1020\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1007\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1067\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                },\n                {\n                    \"privilege\": \"create\"\n                },\n                {\n                    \"privilege\": \"edit\"\n                },\n                {\n                    \"privilege\": \"delete\"\n                },\n                {\n                    \"privilege\": \"approve\"\n                },\n                {\n                    \"privilege\": \"cancel\"\n                }\n            ]\n        },\n        {\n            \"functionId\": \"1036\",\n            \"assignedPrivileges\": [\n                {\n                    \"privilege\": \"view\"\n                }\n            ]\n        }\n    ],\n    \"validFromDate\": \"2020-03-31\",\n    \"validFromTime\": \"07:48:23\",\n    \"validUntilDate\": \"2022-03-31\",\n    \"validUntilTime\": \"07:48:23\"\n}"
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
        
//        getAccessTokenDBS { [weak self] (result) in
//            if result {
                requestAssignPermission(request: request) { (response) in
                    switch response {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
//            } else {
//                completion(.failure(APIError.tokenExpired))
//            }
//        }
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
//        let mobileItem = items[0]
//        let transactionItem = items[1]
//        let salaryItem = items[2]
        
        let paymentItem = items[0]
        
        
//        let parameters = "{\n  \"name\": \"\(request.name)\",\n  \"description\": \"\(request.description)\",\n  \"serviceAgreementId\": \"\(request.serviceAgreementId)\",\n  \"type\": \"ARRANGEMENTS\",\n  \"items\": [\n    \"\(mobileItem)\",\n    \"\(transactionItem)\",\n    \"\(salaryItem)\"\n  ]\n}"
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
        
//        getAccessTokenDBS { [weak self] (result) in
//            if result {
                
                requestCreateDataGroup(request: request) { (response) in
                    switch response {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
//            } else {
//                completion(.failure(APIError.tokenExpired))
//            }
//        }
    }
}

public struct TCBAddUserAsSAAdminRequest {
    public var externalUserId: String
    public let externalServiceAgreementId: String = Backbase.dbsExternalServiceAgreementId
    
}

struct TCBAddUserAsSAAdminResponse: Codable {
    
    var action: String?
    var externalServiceAgreementId: String?
    var resourceId: String?
    var status: String?
    var errors: [String]?
    
}

struct TCBCreateArrangementRequest {
    
    var id: String
    var name: String
    var IBAN: String
    var bookedBalance: Double
    var availableBalance: Double
    var creditLimit: Double
    // default
    let legalEntityIds: [String] = ["Techcombank"]
    var productId: String = "p001"
    let alias: String =  "alias11"
    let BBAN: String =  "BBAN"
    let currency: String =  "EUR"
    let externalTransferAllowed: Bool =  true
    let urgentTransferAllowed: Bool =  false
    let accruedInterest: Double =  100.00
    let number: String =  "PANS"
    let principalAmount: Double =  100.4
    let currentInvestmentValue: Double =  100.5
    let BIC: String =  "BIC123"
    let bankBranchCode: String =  "bankBranchCode1"
}

struct TCBCreateArrangementResponse: Codable {
    var arrangementId: String?
    var message: String?
    //    var errors: [ErrorCreateArrangement]?
    
    enum CodingKeys: String, CodingKey {
        case arrangementId = "id"
        case message = "message"
    }
}

struct ErrorCreateArrangement: Codable {
    var message: String?
    var key: String?
}

struct TCBCreateFunctionGroupsRequest {
    
    var name: String
    var description: String
    var externalServiceAgreementId: String = Backbase.dbsExternalServiceAgreementId
    
}

struct TCBCreateFunctionGroupsResponse: Codable {
    var functionGroupId: String?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case functionGroupId = "id"
        case message = "message"
    }
}

struct TCBCreateDataGroupRequest {
    
    var name: String
    var description: String
    let serviceAgreementId: String = Backbase.dbsServiceAgreementId
    let type: String = "ARRANGEMENTS"
    var items: [String]
    
}

struct TCBCreateDataGroupResponse: Codable {
    var dataGroupId: String?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case dataGroupId = "id"
        case message = "message"
    }
}

struct TCBAssignPermissionRequest {
    
    var functionGroupId: String
    var dataGroupId: String
    var userInternalId: String
    
}

struct TCBAssignPermissionResponse: Codable {
    
    var message: String?
//    var approvalStatus: String?
    
}

struct TCBMobileTransactionSalaryArrangementsRequest {
    var username: String
}

class Logger {
    
    // MARK: - Lifecycle
    
    private init() {} // Disallows direct instantiation e.g.: "Logger()"
    
    // MARK: - Logging
    
    class func log(_ messages: [(key: String, value: Any?)] = [],
                   withEmoji: Bool = true,
                   filename: String = #file,
                   function: String =  #function,
                   line: Int = #line) {
        
        if withEmoji {
            let body = emojiBody(filename: filename, function: function, line: line)
            emojiLog(messageHeader: emojiHeader(), messageBody: body)
            
        } else {
            let body = regularBody(filename: filename, function: function, line: line)
            regularLog(messageHeader: regularHeader(), messageBody: body)
        }
        
        for (key, value) in messages {
            if let data = value as? Data {
                let str = String(decoding: data, as: UTF8.self)
                print(" └ 📣  \(key) -> \(str)\n")
            } else if let error = value as? Error {
                print(" └ 📣  \(key) -> \(error.localizedDescription)\n")
            } else if let response = value as? URLResponse {
                print(" └ 📣  \(key) -> \(response.description)\n")
            } else if let value = value {
                let messageString = String(describing: value)
                print(" └ 📣  \(key) -> \(messageString)\n")
            }
        }
    }
}

// MARK: - Private

// MARK: Emoji

private extension Logger {
    
    class func emojiHeader() -> String {
        return "⏱ \(formattedDate())"
    }
    
    class func emojiBody(filename: String, function: String, line: Int) -> String {
        return "🗂 \(filenameWithoutPath(filename: filename)), in 🔠 \(function) at #️⃣ \(line)"
    }
    
    class func emojiLog(messageHeader: String, messageBody: String) {
        print("\(messageHeader) │ \(messageBody)")
    }
}

// MARK: Regular

private extension Logger {
    
    class func regularHeader() -> String {
        return " \(formattedDate()) "
    }
    
    class func regularBody(filename: String, function: String, line: Int) -> String {
        return " \(filenameWithoutPath(filename: filename)), in \(function) at \(line) "
    }
    
    class func regularLog(messageHeader: String, messageBody: String) {
        let headerHorizontalLine = horizontalLine(for: messageHeader)
        let bodyHorizontalLine = horizontalLine(for: messageBody)
        
        print("┌\(headerHorizontalLine)┬\(bodyHorizontalLine)┐")
        print("│\(messageHeader)│\(messageBody)│")
        print("└\(headerHorizontalLine)┴\(bodyHorizontalLine)┘")
    }
    
    /// Returns a `String` composed by horizontal box-drawing characters (─) based on the given message length.
    ///
    /// For example:
    ///
    ///     " ViewController.swift, in viewDidLoad() at 26 " // Message
    ///     "──────────────────────────────────────────────" // Returned String
    ///
    /// Reference: [U+250x Unicode](https://en.wikipedia.org/wiki/Box-drawing_character)
    class func horizontalLine(for message: String) -> String {
        return Array(repeating: "─", count: message.count).joined()
    }
}

// MARK: Util

private extension Logger {
    
    /// "/Users/blablabla/Class.swift" becomes "Class.swift"
    class func filenameWithoutPath(filename: String) -> String {
        return URL(fileURLWithPath: filename).lastPathComponent
    }
    
    /// E.g. `15:25:04.749`
    class func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        return "\(dateFormatter.string(from: Date()))"
    }
}
