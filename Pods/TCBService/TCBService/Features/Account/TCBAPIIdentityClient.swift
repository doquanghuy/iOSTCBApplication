//
//  TCBHTTPIdentityAuthClient.swift
//  TCBService
//
//  Created by Son le on 10/27/20.
//

import Backbase
import TCBDomain

protocol TCBHTTPAuthService: TCBAuthService {
    func createUser(request: TCBCreateUserRequest, completion: @escaping (TCBResult<User>) -> ())
    func deleteUser(request: TCBDeleteRequest, completion: @escaping (TCBResult<TCBDeleteResponse>) -> ())
    func resetPassword(request: TCBResetPasswordRequest, completion: @escaping (TCBResult<TCBResetPasswordResponse>) -> ())
    func updateInfoUser(request: TCBUpdateInfoUserRequest, completion: @escaping (TCBResult<TCBUpdateInfoUserResponse>) -> ())
    func logOut()
    func adminLogin(completion: @escaping (TCBResult<Bool>) -> Void)
    func lookupAccountInfo(name: String, completion: @escaping TCBResponseCompletion<[TCBCard]>)
}

extension Backbase {
    class var identityRealm: String {
        return configuration().backbase.identity.realm
    }
    
    class var identityClientId: String {
        return configuration().backbase.identity.clientId
    }
    
    class var identityBaseURL: String {
        return configuration().backbase.identity.baseURL
    }
    
    class var dbsBaseURL: String {
        if let customConfig = Backbase.configuration().custom, let dbs = customConfig["dbs"] as? Dictionary<String, String>, let baseURL = dbs["baseURL"] {
            return baseURL
        }
        return ""
    }
    
    class var dbsGateway: String {
        if let customConfig = Backbase.configuration().custom, let dbs = customConfig["dbs"] as? Dictionary<String, String>, let gateway = dbs["gateway"] {
            return gateway
        }
        return ""
    }
    
    class var dbsServiceAgreementId: String {
        if let customConfig = Backbase.configuration().custom, let dbs = customConfig["dbs"] as? Dictionary<String, String>, let serviceAgreementId = dbs["serviceAgreementId"] {
            return serviceAgreementId
        }
        return ""
    }
    
    class var dbsExternalServiceAgreementId: String {
        if let customConfig = Backbase.configuration().custom, let dbs = customConfig["dbs"] as? Dictionary<String, String>, let externalServiceAgreementId = dbs["externalServiceAgreementId"] {
            return externalServiceAgreementId
        }
        return ""
    }
    
    class var dbsLegalEntityInternalId: String {
        if let customConfig = Backbase.configuration().custom, let dbs = customConfig["dbs"] as? Dictionary<String, String>, let legalEntityInternalId = dbs["legalEntityInternalId"] {
            return legalEntityInternalId
        }
        return ""
    }
    
    class var dbsSearchBasePath: String {
        if let customConfig = Backbase.configuration().custom, let dbs = customConfig["dbs"] as? Dictionary<String, String>, let searchIBANURL = dbs["searchIBANURL"] {
            return searchIBANURL
        }
        return ""
    }
    
    class var dbsRandomString: String {
        return UUID().uuidString
    }
    
    class var iban: String {
        var account = String(Int.random(in: 10_000...99_999))
        var bank = String(10010424)
        
        let countryCode = "de"
        let iban_code = IBANtools.convertToIBAN(&account, bankCode: &bank, countryCode: countryCode).iban
        return iban_code
    }
    
    
}

class TCBHTTPIdentityAuthClient: NSObject {}

//MARK: - Conform Backbase AuthClient
extension TCBHTTPIdentityAuthClient: AuthClient {
    
    func endSession(with delegate: AuthClientDelegate?) { }
    
    func checkSessionValidity(_ delegate: AuthClientDelegate?) { }
    
    func tokens() -> [String : String] { return [:] }
    
    func startSessionObserver(_ delegate: AuthClientDelegate) throws { }
    
    func endSessionObserver() { }
}

extension TCBHTTPIdentityAuthClient: TCBHTTPAuthService {
    private var host: String {
        return Backbase.identityBaseURL
    }
    
    private var gateway: String {
        return Backbase.dbsGateway
    }
    
    private var loginUserPath: String {
        return "/auth/realms/\(Backbase.identityRealm)/protocol/openid-connect/token"
    }
    
    private var loginAdminPath: String {
        return "/auth/realms/master/protocol/openid-connect/token"
    }
    
    private var createUserPath: String {
        return "/auth/admin/realms/\(Backbase.identityRealm)/users"
    }
    
    private func resetPasswordPath(_ userId: String) -> String {
        return "/auth/admin/realms/\(Backbase.identityRealm)/users/\(userId)/reset-password"
    }
    
    private func deleteUserPath(_ userId: String) -> String {
        return "/auth/admin/realms/\(Backbase.identityRealm)/users/\(userId)"
    }
    
    private func updateInfoUserPath(_ userId: String) -> String {
        return "/user-manager/client-api/v2/users/identities/\(userId)"
    }
    
    private var searchCardPath: String {
        return "/arrangement-manager/service-api/v2/arrangements/filter"
    }
    
    func login(request: TCBLoginRequest, completion: @escaping (TCBResult<User>) -> ()) {
        //TODO
    }
    
    func getAccessTokenAdmin(completion: @escaping ((Bool) -> Void)) {
        if TCBSessionManager.shared.getAccessTokenAdmin() == nil {
            adminLogin() { (result) in
                switch result {
                case .success(let data):
                    completion(data)
                case .failure(_):
                    completion(false)
                }
            }
        } else {
            completion(true)
        }
    }
    
    func createUser(request: TCBCreateUserRequest, completion: @escaping (TCBResult<User>) -> ()) {
        //0. check token
        getAccessTokenAdmin { [weak self] (result) in
            if result {
                self?.createUserStepByStep(request: request) { (response) in
                    switch response {
                    case .success(let data):
                        let setupUserToDBSRequest = SetupUserToDBSRequest(username: data.userCredentials?.email ?? "", password: data.userCredentials?.password ?? "")
                        self?.setupUserToDBS(request: setupUserToDBSRequest) { (responseUserToDBS) in
                            switch responseUserToDBS {
                            case .success(let dataUserToDBS):
                                if dataUserToDBS {
                                    completion(.success(data))
                                } else {
                                    completion(.failure(APIError.unknown))
                                }
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else {
                // todo:
                completion(.failure(APIError.tokenExpired))
            }
        }
    }
    
    private func createUserStepByStep(request: TCBCreateUserRequest, completion: @escaping (TCBResult<User>) -> ()) {
        //1. create user
        requestCreateUser(request: request) { [weak self] (createResponse) in
            switch createResponse {
            case .success(let data):
                if let userId = data.userId {
                    //2. update password
                    let resetPasswordRequest = TCBResetPasswordRequest(userId: userId, type: Parameter.password.value, value: request.password, temporary: false)
                    self?.resetPassword(request: resetPasswordRequest) { (resetPasswordResponse) in
                        switch resetPasswordResponse {
                        case .success(_):
                            //3.1 success
                            completion(.success(User(firstName: request.firstName, lastName: request.lastName, email: request.email, userId: userId, userCredentials: UserCredentials(email: request.username, password: request.password))))
                        case .failure(let error):
                            //3.2 delete user
                            let deleteRequest = TCBDeleteRequest(userId: userId)
                            self?.deleteUser(request: deleteRequest) { (deleteResponse) in
                                completion(.failure(error))
                            }
                        }
                    }
                } else {
                    completion(.failure(APIError.unknown))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func setupUserToDBS(request: SetupUserToDBSRequest, completion: @escaping (TCBResult<Bool>) -> ()) {
        
        // 4. import user to dbs
        let dbsClient = TCBDBSClient()
        let importIdentityUserToDBSRequest = TCBImportIdentityUserToDBSRequest(externalId: request.username, legalEntityInternalId: Backbase.dbsLegalEntityInternalId)
        dbsClient.importIdentityUserToDBS(request: importIdentityUserToDBSRequest) { (responseImportIdentityUserToDBS) in
            switch responseImportIdentityUserToDBS {
            case .success(let dataImportIdentityUserToDBS):
                
                // 5. add user as sa admin
                let addUserAsSAAdminRequest = TCBAddUserAsSAAdminRequest(externalUserId: dataImportIdentityUserToDBS.externalId ?? "")
                dbsClient.addUserAsSAAdmin(request: addUserAsSAAdminRequest) { (responseAddUserAsSAAdmin) in
                    switch responseAddUserAsSAAdmin {
                    case .success(_):
                        // login identity to get access token
                        let identityAuthClient: TCBAuthService = TCBServiceFactory.loadService()
                        let loginRequest = TCBLoginRequest(username: request.username, password: request.password)
                        identityAuthClient.login(request: loginRequest) { (loginResponse) in
                            switch loginResponse {
                            case .success(_):
                                // 6. create arrangement
                                let mobileTransactionSalaryArrangements = TCBMobileTransactionSalaryArrangementsRequest(username: request.username)
                                dbsClient.createMobileTransactionSalaryArrangements(request: mobileTransactionSalaryArrangements) { (responseCreateArrangements) in
                                    switch responseCreateArrangements {
                                    case .success(let items):
                                        if items.count > 0 {
                                            // 7. create data group
                                            let nameDataGroup = "\(request.username) - data group - \(items.joined(separator: "-"))"
                                            let descriptionDataGroup = "\(request.username) - data group - \(items.joined(separator: "-"))"
                                            let createDataGroupRequest = TCBCreateDataGroupRequest(name: nameDataGroup, description: descriptionDataGroup, items: items)
                                            dbsClient.createDataGroup(request: createDataGroupRequest) { (responseCreateDataGroup) in
                                                switch responseCreateDataGroup {
                                                case .success(let dataCreateDataGroup):
                                                    
                                                    // 8. create function groups
                                                    let nameFunctionGroup = "\(request.username) - function group - \(items.joined(separator: "-"))"
                                                    let descriptionFunctionGroup = "\(request.username) - function group - \(items.joined(separator: "-"))"
                                                    let createFunctionGroupsRequest = TCBCreateFunctionGroupsRequest(name: nameFunctionGroup, description: descriptionFunctionGroup)
                                                    dbsClient.createFunctionGroups(request: createFunctionGroupsRequest) { (responseCreateFunctionGroups) in
                                                        switch responseCreateFunctionGroups {
                                                        case .success(let dataCreateFunctionGroups):
                                                            
                                                            // 9. assign permission
                                                            let assignPermissionRequest = TCBAssignPermissionRequest(functionGroupId: dataCreateFunctionGroups.functionGroupId ?? "", dataGroupId: dataCreateDataGroup.dataGroupId ?? "", userInternalId: dataImportIdentityUserToDBS.internalId ?? "")
                                                            dbsClient.assignPermission(request: assignPermissionRequest) { (responseAssignPermission) in
                                                                switch responseAssignPermission {
                                                                case .success(_):
                                                                    completion(.success(true))
                                                                case .failure(_):
                                                                    completion(.success(false))
                                                                }
                                                            }
                                                        case .failure(_):
                                                            completion(.success(false))
                                                        }
                                                    }
                                                case .failure(_):
                                                    completion(.success(false))
                                                }
                                            }
                                            
                                        } else {
                                            completion(.success(false))
                                        }
                                    case .failure(_):
                                        completion(.success(false))
                                    }
                                }
                            case .failure(_):
                                completion(.success(false))
                            }
                        }
                        
                        
                    case .failure(_):
                        completion(.success(false))
                    }
                }
            case .failure(_):
                completion(.success(false))
            }
        }
    }
    
    func requestCreateUser(request: TCBCreateUserRequest, completion: @escaping (TCBResult<User>) -> ()) {
        
        
        let urlString = host + createUserPath
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.urlError))
            return
        }
        
        guard let accessToken = TCBSessionManager.shared.getAccessTokenAdmin() else {
            completion(.failure(APIError.tokenExpired))
            return
        }

        let parameters = "{\n    \"username\": \"\(request.username)\",\n    \"firstName\": \"\(request.firstName)\",\n    \"lastName\": \"\(request.lastName)\",\n    \"email\": \"\(request.email)\",\n    \"enabled\": \"true\",\n    \"requiredActions\": []\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: url)
        let authorization = Authorization.bearer(accessToken).value
        request.addValue(authorization, forHTTPHeaderField: HTTPHeader.authorization.value)
        request.addValue(ContentType.applicationJson.value, forHTTPHeaderField: HTTPHeader.contentType.value)
        request.httpMethod = HTTPMethod.post.value
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            Logger.log([(key: "url", value: urlString), (key: "parameters", value: parameters), (key: "data", value: data), (key: "response", value: response), (key: "error", value: error)])
            
            if let response = response as? HTTPURLResponse, let location = response.allHeaderFields[HTTPHeader.location.value] as? String, let userId = location.components(separatedBy: "/").last {
                completion(.success(User(userId: userId)))
            } else if let response = response as? HTTPURLResponse, let statusCode = HTTPStatusCode(rawValue: response.statusCode), statusCode == HTTPStatusCode.unauthorized {
                TCBSessionManager.shared.setAccessToken("admin", nil)
                TCBSessionManager.shared.setRefreshToken("admin", nil)
                completion(.failure(APIError.tokenExpired))
            } else if let error = error {
                // Handle HTTP request error
                completion(.failure(error))
            } else if let data = data {
                // Handle HTTP request response
                do {
                    let jsonData = try JSONDecoder().decode(TCBCreateUserResponse.self, from: data)
                    if let errorMessage = jsonData.errorMessage {
                        completion(.failure(APIError.errorMessage(errorMessage)))
                    } else {
                        // don't execute
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
    
    func deleteUser(request: TCBDeleteRequest, completion: @escaping (TCBResult<TCBDeleteResponse>) -> ()) {
        getAccessTokenAdmin { [weak self] (result) in
            if result {
                self?.requestDeleteUser(request: request) { (response) in
                    switch response {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure((error)))
                    }
                }
            } else {
                // todo:
                completion(.failure(APIError.tokenExpired))
            }
        }
    }
    
    func requestDeleteUser(request: TCBDeleteRequest, completion: @escaping (TCBResult<TCBDeleteResponse>) -> ()) {
        
        let urlString = host + deleteUserPath(request.userId)
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.urlError))
            return
        }
        
        guard let accessToken = TCBSessionManager.shared.getAccessTokenAdmin() else {
            completion(.failure(APIError.tokenExpired))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(Authorization.bearer(accessToken).value, forHTTPHeaderField: HTTPHeader.authorization.value)
        request.httpMethod = HTTPMethod.delete.value
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            Logger.log([(key: "url", value: urlString), (key: "parameters", value: nil), (key: "data", value: data), (key: "response", value: response), (key: "error", value: error)])
            
            if let response = response as? HTTPURLResponse, let statusCode = HTTPStatusCode(rawValue: response.statusCode)?.responseType, statusCode == HTTPStatusCode.ResponseType.success {
                // Handle HTTP request response
                completion(.success(TCBDeleteResponse()))
            } else if let response = response as? HTTPURLResponse, let statusCode = HTTPStatusCode(rawValue: response.statusCode), statusCode == HTTPStatusCode.unauthorized {
                TCBSessionManager.shared.setAccessToken("admin", nil)
                TCBSessionManager.shared.setRefreshToken("admin", nil)
                completion(.failure(APIError.tokenExpired))
            } else if let error = error {
                // Handle HTTP request error
                completion(.failure((error)))
            } else {
                // Handle unexpected error
                completion(.failure(APIError.unknown))
            }
        }
        task.resume()
    }
    
    func resetPassword(request: TCBResetPasswordRequest, completion: @escaping (TCBResult<TCBResetPasswordResponse>) -> ()) {
        getAccessTokenAdmin { [weak self] (result) in
            if result {
                self?.requestResetPassword(request: request) { (response) in
                    switch response {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure((error)))
                    }
                }
            } else {
                // todo:
                completion(.failure(APIError.tokenExpired))
            }
        }
    }
    
    func requestResetPassword(request: TCBResetPasswordRequest, completion: @escaping (TCBResult<TCBResetPasswordResponse>) -> ()) {
        
        let urlString = host + resetPasswordPath(request.userId)
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.urlError))
            return
        }
        
        guard let accessToken = TCBSessionManager.shared.getAccessTokenAdmin() else {
            completion(.failure(APIError.tokenExpired))
            return
        }
        
        let parameters = "{\n    \"type\": \"password\",\n    \"value\": \"\(request.value)\",\n    \"temporary\": false\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: url)
        request.addValue(Authorization.bearer(accessToken).value, forHTTPHeaderField: HTTPHeader.authorization.value)
        request.addValue(ContentType.applicationJson.value, forHTTPHeaderField: HTTPHeader.contentType.value)
        request.httpMethod = HTTPMethod.put.value
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            Logger.log([(key: "url", value: urlString), (key: "parameters", value: parameters), (key: "data", value: data), (key: "response", value: response), (key: "error", value: error)])
            
            if let response = response as? HTTPURLResponse, let statusCode = HTTPStatusCode(rawValue: response.statusCode)?.responseType, statusCode == HTTPStatusCode.ResponseType.success {
                // Handle HTTP request response
                completion(.success(TCBResetPasswordResponse()))
            } else if let response = response as? HTTPURLResponse, let statusCode = HTTPStatusCode(rawValue: response.statusCode), statusCode == HTTPStatusCode.unauthorized {
                TCBSessionManager.shared.setAccessToken("admin", nil)
                TCBSessionManager.shared.setRefreshToken("admin", nil)
                completion(.failure(APIError.tokenExpired))
            } else if let error = error {
                // Handle HTTP request error
                completion(.failure(error))
            }  else if let data = data {
                // Handle HTTP request response
                do {
                    let jsonData = try JSONDecoder().decode(TCBResetPasswordResponse.self, from: data)
                    if let errorMessage = jsonData.errorDescription {
                        completion(.failure(APIError.errorMessage(errorMessage)))
                    } else {
                        // don't execute
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
    
    func updateInfoUser(request: TCBUpdateInfoUserRequest, completion: @escaping (TCBResult<TCBUpdateInfoUserResponse>) -> ()) {
        
        requestUpdateInfoUser(request: request) { (response) in
            switch response {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure((error)))
            }
        }
    }
    
    func requestUpdateInfoUser(request: TCBUpdateInfoUserRequest, completion: @escaping (TCBResult<TCBUpdateInfoUserResponse>) -> ()) {
        
        let urlString = gateway + updateInfoUserPath(request.userId)
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.urlError))
            return
        }
        
        guard let accessToken = TCBSessionManager.shared.getAccessTokenUser() else {
            completion(.failure(APIError.tokenExpired))
            return
        }
        
        let parameters = "{\n    \"givenName\": \"\(request.firstName)\",\n    \"familyName\": \"\(request.lastName)\",\n    \"emailAddress\": \"\(request.email)\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: url)
        request.addValue(Authorization.bearer(accessToken).value, forHTTPHeaderField: HTTPHeader.authorization.value)
        request.addValue(ContentType.applicationJson.value, forHTTPHeaderField: HTTPHeader.contentType.value)
        request.httpMethod = HTTPMethod.put.value
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            Logger.log([(key: "url", value: urlString), (key: "parameters", value: parameters), (key: "data", value: data), (key: "response", value: response), (key: "error", value: error)])
            
            if let response = response as? HTTPURLResponse, let statusCode = HTTPStatusCode(rawValue: response.statusCode)?.responseType, statusCode == HTTPStatusCode.ResponseType.success {
                // Handle HTTP request response
                completion(.success(TCBUpdateInfoUserResponse()))
            } else if let response = response as? HTTPURLResponse, let statusCode = HTTPStatusCode(rawValue: response.statusCode), statusCode == HTTPStatusCode.unauthorized {
                TCBSessionManager.shared.setAccessTokenUser(nil)
                completion(.failure(APIError.tokenExpired))
            } else if let error = error {
                // Handle HTTP request error
                completion(.failure(error))
            } else if let data = data {
                // Handle HTTP request response
                do {
                    let jsonData = try JSONDecoder().decode(TCBUpdateInfoUserResponse.self, from: data)
                    if let errorMessage = jsonData.message {
                        completion(.failure(APIError.errorMessage(errorMessage)))
                    } else {
                        // don't execute
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
    
    private func currentTimeMillis() -> Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    func logOut() {
        TCBSessionManager.shared.setAccessTokenUser(nil)
        TCBSessionManager.shared.setRefreshTokenUser(nil)
    }
}

// MARK: - Thuy's API
extension TCBHTTPIdentityAuthClient {
    func retrieveProfile(completion: @escaping (_ error: ErrorEntity?, _ response: ProfileEntity?) -> Void) {
        if let url = URL(string: host + "/auth/realms/\(Backbase.identityRealm)/protocol/openid-connect/userinfo") {
            var request = URLRequest(url: url)
            
            if let token = TCBSessionManager.shared.getAccessTokenUser() {
                request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil, let data = data, !data.isEmpty else {
                    return
                }
                
                do {
                    let entity = try JSONDecoder().decode(ProfileEntity.self, from: data)
                    
                    completion(nil, entity)
                } catch {
                    let error = ErrorEntity(error: "", errorDescription: "Parsing data is error")
                    completion(error, nil)
                }
            }
            task.resume()
        }
    }
    
    func adminLogin(completion: @escaping (TCBResult<Bool>) -> Void) {
        
        let urlString = host + loginAdminPath
        guard let url = URL(string: urlString) else {
            completion(.success(false))
            return
        }
        
        var requestBody = URLComponents()
        requestBody.queryItems = [
            URLQueryItem(name: "grant_type", value: "password"),
            URLQueryItem(name: "username", value: "admin"),
            URLQueryItem(name: "password", value: "admin"),
            URLQueryItem(name: "client_id", value: "security-admin-console"),
        ]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = requestBody.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            Logger.log([(key: "url", value: urlString), (key: "parameters", value: requestBody.queryItems), (key: "data", value: data), (key: "response", value: response), (key: "error", value: error)])
            
            guard let data = data,
                  let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                completion(.success(false))
                return
            }
            
            if let token = jsonData["access_token"] as? String {
                TCBSessionManager.shared.setAccessToken("admin", token)
                TCBSessionManager.shared.setRefreshToken("admin", jsonData["refresh_token"] as? String)
                completion(.success(true))
            } else {
                completion(.success(false))
            }
        }
        task.resume()
    }
    
    func lookupAccountInfo(name: String, completion: @escaping TCBResponseCompletion<[TCBCard]>) {
        let urlString = Backbase.dbsSearchBasePath + searchCardPath
            guard let url = URL(string: urlString) else {
                completion(.error(APIError.urlError))
                return
            }
            
            let parameters: [String: String] = ["searchTerm": name]
            
            var urlRequest = URLRequest(url: url)
            urlRequest.addValue(ContentType.applicationJson.value, forHTTPHeaderField: HTTPHeader.contentType.value)
            urlRequest.httpMethod = HTTPMethod.post.rawValue
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                Logger.log([(key: "url", value: urlString),
                            (key: "parameters", value: parameters),
                            (key: "data", value: data),
                            (key: "response", value: response),
                            (key: "error", value: error)])
                
                guard let data = data,
                      let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let arrangementElements = jsonData["arrangementElements"] as? [[String: Any]],
                      let arrangementData = try? JSONSerialization.data(withJSONObject: arrangementElements, options: .prettyPrinted) else {
                    completion(.error(APIError.unknown))
                    return
                }
                print("Cards data: \(jsonData)")
                let jsonDecoder = JSONDecoder()
                do {
                    let cards = try jsonDecoder.decode([TCBCard].self, from: arrangementData)
                    completion(.success(cards))
                } catch {
                    completion(.error(APIError.unknown))
                }
            }
            task.resume()
        } catch {
            completion(.error(APIError.unknown))
        }
    }
}

struct TCBUpdateInfoUserRequest {
    var userId: String
    var createdTimestamp: Int?
    var username: String
    var enabled: Bool?
    var totp: Bool?
    var emailVerified: Bool?
    var firstName: String
    var lastName: String
    var email: String
    var disableableCredentialTypes: [String]?
    var requiredActions: [String]?
    var notBefore: Int?
    struct Access {
        var manageGroupMembership: Bool
        var view: Bool
        var mapRoles: Bool
        var impersonate: Bool
        var manage: Bool
    }
    var access: Access?
    var attributes: String?
    
    init(userId: String, createdTimestamp: Int? = nil, username: String, enabled: Bool? = nil, totp: Bool? = nil, emailVerified: Bool? = nil, firstName: String, lastName: String, email: String, disableableCredentialTypes: [String]? = nil, requiredActions: [String]? = nil, notBefore: Int? = nil, access: Access? = nil, attributes: String? = nil) {
        self.userId = userId
        self.createdTimestamp = createdTimestamp
        self.username = username
        self.enabled = enabled
        self.totp = totp
        self.emailVerified = emailVerified
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.disableableCredentialTypes = disableableCredentialTypes
        self.requiredActions = requiredActions
        self.notBefore = notBefore
        self.access = access
        self.attributes = attributes
    }
}
