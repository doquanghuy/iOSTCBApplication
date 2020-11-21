//
//  TCBValidateTokenClient.swift
//  TCBService
//
//  Created by Son le on 10/30/20.
//

import Backbase
import Domain

public class TCBValidateTokenClient: NSObject {
    private var host: String {
        return Backbase.configuration().backbase.identity.baseURL
    }

    private var path: String {
        return "/auth/realms/master/protocol/openid-connect/userinfo"
    }

    private var client: TCBHTTPIdentityAuthClient!
    private var completion: ((User?) -> ())?
    public override init() {
        self.client = TCBHTTPIdentityAuthClient()
    }
}

extension TCBValidateTokenClient: TCBValidateTokenServices {
    public func getValidation(completion: @escaping (User?) -> ()) {
        self.completion = completion
        Backbase.authClient().checkSessionValidity(self)
        
//        checkValidation { (result) in
//            if let user = result.value {
//                completion(user)
//            } else {
//                completion(nil)
//            }
//        }
    }

    func checkValidation(completion: @escaping (TCBResult<User?>) -> ()) {
        guard let url = URL(string: host + path) else {
            completion(.failure(TCBCommunityAuthClient.urlError))
            return
        }

        var urlRequest = URLRequest(url: url)
        if let token = TCBSessionManager.shared.getAccessTokenUser(), !token.isEmpty {
            urlRequest.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            
            if let response = response as? HTTPURLResponse, let statusCode = HTTPStatusCode(rawValue: response.statusCode)?.responseType, statusCode == HTTPStatusCode.ResponseType.success {
                // Handle HTTP request response
                guard let data = data,
                      let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    completion(.failure(TCBHTTPIdentityAuthClient.jsonError))
                    return
                }
                
                let userCredentials = UserCredentials(email: (jsonData["preferred_username"] as? String) ?? "", password: "")
                let user = User(name: jsonData["name"] as? String,
                                firstName: jsonData["family_name"] as? String,
                                lastName: jsonData["given_name"] as? String,
                                email: jsonData["email"] as? String,
                                userId: jsonData["sub"] as? String,
                                userCredentials: userCredentials)
                completion(.success(user))
                
            } else {
                completion(.failure(TCBHTTPIdentityAuthClient.jsonError))
            }
        }
        task.resume()
    }
}

extension TCBValidateTokenClient: AuthClientDelegate {
    public func sessionState(_ newSessionState: SessionState) {
        switch newSessionState {
        case .valid:
            completion?(User())
        default:
            completion?(nil)
        }
    }
}
