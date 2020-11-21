import Backbase
import Domain

public struct ErrorEntity: Error, Codable {
    public var error: String
    public var errorDescription: String

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case errorDescription = "error_description"
    }
}

class TCBCommunityAuthClient: BBAuthClient {
    let kPasscodeTokenKey = "passcodeToken"
    let kNameTokenKey = "nameToken"
    let kAvatarURLKey = "avatarURLKey"
    let kAvatarTokenKey = "avatarToken"

    #if CXP || DBS
        private weak var passcodeDelegate: PasscodeAuthClientDelegate?
        private lazy var cxpClient = CXPAuthClient(configuration: Backbase.configuration())
    #endif

    let endpoint = URL(string: "https://community.backbase.com/")!
    var realmIdentifier = "master"
    var hostTemp = URL(string: "http://10.62.44.114:8180")
    
    static let genericError = NSError(domain: NSURLErrorDomain,
                                      code: 401,
                                      userInfo: [NSLocalizedDescriptionKey: "Unable to authenticate try again later"])
    static let urlError = NSError(domain: NSURLErrorDomain,
                                  code: NSURLErrorBadURL,
                                  userInfo: [NSLocalizedDescriptionKey: "A malformed URL prevented a URL request from being initiated."])
    lazy var persistentStorage = (Backbase.registered(plugin: EncryptedStorage.self) as? EncryptedStorage)?.storageComponent

    var name: String? {
        return persistentStorage?.getItem(kNameTokenKey)
    }
    var avatarURL: String? {
        return persistentStorage?.getItem(kAvatarURLKey)
    }

    private var userImage: UIImage? {
        get {
            guard let data = UserDefaults.standard.object(forKey: kAvatarTokenKey) as? Data else { return nil }
            return UIImage(data: data)
        }
        set {
            guard let newValue = newValue else {
                UserDefaults.standard.removeObject(forKey: kAvatarTokenKey)
                return
            }
            UserDefaults.standard.set(newValue.pngData(), forKey: kAvatarTokenKey)
        }
    }

    var avatar: UIImage? {
        return userImage
    }

    private var authenticationHandler: ((TCBResult<User>) -> ())?

    override func authenticate(withUserId userIdentifier: String,
                               credentials: String,
                               headers: [String: String]?,
                               additionalBodyParameters bodyParameters: [String: String]?,
                               tokenNames: [Any],
                               delegate: PasswordAuthClientDelegate?) {
        getCSRF { [weak self] key, error in
            guard let key = key else {
                delegate?.authenticationDidFail(with: error ?? TCBCommunityAuthClient.genericError)
                return
            }
            if let error = error {
                delegate?.authenticationDidFail(with: error)
                return
            }

            self?.login(username: userIdentifier, password: credentials, csrf: key) { error in
                if let error = error {
                    delegate?.authenticationDidFail(with: error)
                    return
                }
                delegate?.authenticationDidSucceed(with: [:])
            }
        }
    }

    private func printToFile(fileName: String, keys: [String]) {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let filename = path.appendingPathComponent("\(fileName).txt")
        do {
            try keys.description.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            Backbase.logError(self, message: error.localizedDescription)
        }
    }

    private func printUserDefaults(with fileName: String) {
        #if DEBUG
            guard let bundleId = TCBService.bundle.bundleIdentifier else { return }
            let name = "backbase.bb.ios.keys.\(bundleId)"
            guard let userDefaults = UserDefaults(suiteName: name),
                let keys = userDefaults.object(forKey: "keys") as? [String] else { return }
            printToFile(fileName: fileName, keys: keys)
            userDefaults.removeSuite(named: name)
        #endif
    }

    override func checkSessionValidity(_ delegate: AuthClientDelegate?) {
        let state: SessionState = isEnrolled() ? .valid : .none
        if state == .none {
            printUserDefaults(with: "bbapp_session_validity")
        }
        delegate?.sessionState(state)
    }

    override func endSession(with delegate: AuthClientDelegate?) {
        [kPasscodeTokenKey, kNameTokenKey].forEach {
            persistentStorage?.removeItem($0)
        }
        userImage = nil
        Backbase.unregister(errorResponseResolverForCode: NSURLErrorBadURL)
        Backbase.unregister(errorResponseResolverForCode: 401)
        super.endSession(with: delegate)
    }

    internal func login(username: String, password: String, csrf: String,
                        completion: @escaping (_ error: Error?) -> Void) {
        guard let url = URL(string: "session", relativeTo: endpoint) else {
            completion(TCBCommunityAuthClient.urlError)
            return
        }

        let params = "login=\(username)&password=\(password)"

        var request = URLRequest(url: url)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue(csrf, forHTTPHeaderField: "X-CSRF-Token")
        request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        request.httpMethod = "POST"
        request.httpBody = params.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let strongSelf = self,
                let data = data,
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let userData = jsonData["user"] as? [String: Any],
                let name = userData["name"] as? String,
                var avatarURL = userData["avatar_template"] as? String
                else {
                    completion(error ?? TCBCommunityAuthClient.genericError)
                    return
            }

            avatarURL = avatarURL.replacingOccurrences(of: "{size}", with: "144")

            strongSelf.saveUser(name: name, avatarURL: avatarURL)
            completion(error)
        }
        task.resume()
    }

    func retrieveProfile(completion: @escaping (_ error: ErrorEntity?, _ response: ProfileEntity?) -> Void) {
        if let url = URL(string: "auth/realms/\(self.realmIdentifier)/protocol/openid-connect/userinfo", relativeTo: hostTemp) {
            
            var request = URLRequest(url: url)
            
            request.addValue("bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJfdEdtOENoUElRclZuRHFyRzV3NThZdGNLT1dpU1NTeHpBSzFXY2RfQWpBIn0.eyJleHAiOjE2MDM5MTQ1NjYsImlhdCI6MTYwMzg4MjE2NiwianRpIjoiMzYzNjc2ZTctMmI5NC00NTg0LWI5YWMtNDE0YmVhZTgzNzZkIiwiaXNzIjoiaHR0cDovLzEwLjYyLjQ0LjExNDo4MTgwL2F1dGgvcmVhbG1zL21hc3RlciIsInN1YiI6ImZkZTAwNjk5LTQ5M2UtNDI4OS04NGYxLTNjMzExZjU5YzM1MiIsInR5cCI6IkJlYXJlciIsImF6cCI6InNlY3VyaXR5LWFkbWluLWNvbnNvbGUiLCJzZXNzaW9uX3N0YXRlIjoiYzVmODM3ODYtMmZlZS00NGZmLTlhZDItMmY2NmUzMWZmNGNhIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vMTAuNjIuNDQuMTE0OjgxODAiXSwic2NvcGUiOiJlbWFpbCBwcm9maWxlIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoiU2VyZ2V5IEthcmdvcG9sb3YiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJ0ZXN0MTIzIiwiZ2l2ZW5fbmFtZSI6IlNlcmdleSIsImZhbWlseV9uYW1lIjoiS2FyZ29wb2xvdiIsImVtYWlsIjoidGVzdDExMTExMTEyMTExMTFAdGVzdC5jb20ifQ.QMrB9VIfnf-yGWSJ_ipiQxvmeY_o44A7m_FZoIY1YLF-44_WbH774kPRFesoiJJSx-n-VFk-r_ED5LA7bhutrZ_HbmWcoETKzloXkK0esQDupQ_vx6d1mBXZq8efoZF5GaUixnC2XUMZROpAbCt75dMKoJsvfsUj-yp3gDXIISWAixjHxhZw_dvawAKZ0LpeTJzNuZvVo9QB7pXlqFICorrvElQO2MRFuN1e5hOMUH0Y_q51vBjRK66tuOh9MlqZ1mcrWlFbGTMoaqvnNFlL_1M0Oh_pSkfn1d0q2syZ1K_PG4QInqkOlGk10wYosorO-sJh36de6EQlr6ReSxLzlA", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil, let data = data, !data.isEmpty else {
                    return
                }
                
                do {
                    print(response)
                    let entity = try JSONDecoder().decode(ProfileEntity.self, from: data)
                    
                    completion(nil, entity)
                } catch {
                    let error = ErrorEntity(error: "", errorDescription: "Parsing data is error")
                    completion(error, nil)
                }
            }
            
//            task.setValue("", forKey: "bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJfdEdtOENoUElRclZuRHFyRzV3NThZdGNLT1dpU1NTeHpBSzFXY2RfQWpBIn0.eyJleHAiOjE2MDM5MTEzNzUsImlhdCI6MTYwMzg3ODk3NSwianRpIjoiMjJiZGNiNzEtM2ZkMy00NDA3LTkxYTktZDZjYWQ5YWVlZGI3IiwiaXNzIjoiaHR0cDovLzEwLjYyLjQ0LjExNDo4MTgwL2F1dGgvcmVhbG1zL21hc3RlciIsInN1YiI6ImZkZTAwNjk5LTQ5M2UtNDI4OS04NGYxLTNjMzExZjU5YzM1MiIsInR5cCI6IkJlYXJlciIsImF6cCI6InNlY3VyaXR5LWFkbWluLWNvbnNvbGUiLCJzZXNzaW9uX3N0YXRlIjoiOTY1NGRmNDAtMTMxMC00ZDcyLTk4ZDctMzgyMWQ2OWZmZDI4IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vMTAuNjIuNDQuMTE0OjgxODAiXSwic2NvcGUiOiJlbWFpbCBwcm9maWxlIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoiU2VyZ2V5IEthcmdvcG9sb3YiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJ0ZXN0MTIzIiwiZ2l2ZW5fbmFtZSI6IlNlcmdleSIsImZhbWlseV9uYW1lIjoiS2FyZ29wb2xvdiIsImVtYWlsIjoidGVzdDExMTExMTEyMTExMTFAdGVzdC5jb20ifQ.Ay8vkLy9xzxAN64YCIrZB7acDg8kIp8HbmzzpXAA4PSxk8vbBgMRsT5--0YuefQ6Gc4EnVk8nmfH9jWyta4oG0VuE6pjkl3YywiexIbPLIwQq4tZxMVxIcJW8Y1e_er_T-F0jKOz-vQE-o4RAEHDQ7BFk0mn741YjSKDmEl-KyITAKu4tiXRazwAtIATxVP4C8UfhTJdWBGwlTvYq2lBzaAxYks_Tyv4XP5yG1EzZi8jPYo41KsLBUVzHzGotVxFWE0aw1FddBr22fPwKu8bttzFNh5-f_1QHTMRUloM81yb9LSYkJ0atdWFwoa6fD7vkk-shQbiugIUzGs2shvU3A")
            task.resume()
        }
    }
    
    internal func saveUser(name: String, avatarURL: String) {
        persistentStorage?.setItem(name, forKey: kNameTokenKey)

        if let url = URL(string: avatarURL, relativeTo: endpoint) {
            persistentStorage?.setItem(url.absoluteString, forKey: kAvatarURLKey)

            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let self = self else { return }
                guard error == nil, let data = data, !data.isEmpty else {
                    return
                }
                self.userImage = UIImage(data: data)
            }
            task.resume()
        }
    }

    internal func getCSRF(_ completion: @escaping (_ key: String?, _ error: Error?) -> Void) {
        guard let url = URL(string: "session/csrf?_=\(Date().timeIntervalSince1970)", relativeTo: endpoint) else {
            completion(nil, TCBCommunityAuthClient.urlError)
            return
        }

        var request = URLRequest(url: url)
        request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data,
                let response = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let key = response["csrf"] as? String else {
                    completion(nil, TCBCommunityAuthClient.genericError)
                    return
            }

            completion(key, nil)
        }
        task.resume()
    }

    func isEnrolled() -> Bool {
        guard let persistentStorage = persistentStorage else { return false }

        return persistentStorage.getItem(kNameTokenKey) != nil && persistentStorage.getItem(kPasscodeTokenKey) != nil
    }
}


extension TCBCommunityAuthClient: TCBAuthService {
    func login(request: TCBLoginRequest, completion: @escaping (TCBResult<User>) -> ()) {
        authenticationHandler = completion

        authenticate(withUserId: request.username,
                     credentials: request.password,
                     headers: nil,
                     additionalBodyParameters: nil,
                     tokenNames: [],
                     delegate: self)
    }
}

extension TCBCommunityAuthClient: PasswordAuthClientDelegate {
    func authenticationDidSucceed(with headers: [String : String]) {
        let user = User(name: name ?? "", avatarURL: avatarURL ?? "")
        authenticationHandler?(.success(user))
    }

    func authenticationDidFail(with error: Error) {
        authenticationHandler?(.failure(error))
    }
}
