//
//  TCBFirebaseClient.swift
//  Alamofire
//
//  Created by Pham Thanh Hoa on 11/13/20.
//

import Foundation
import TCBDomain

protocol TCBFirebaseService {
    func sendPaymentNotification(userId: String,
                                 completion: @escaping TCBResponseCompletion<FirebaseMessage>)
}

public class TCBFirebaseClient: NSObject {
    private var host: String {
        return "https://fcm.googleapis.com"
    }

    private var path: String {
        return "/fcm/send"
    }
    
    private var key = "AAAAJDIsYSM:APA91bGTs2ocZF0NSyIX0JJosc6aqRe_JRCMugb1DyHgb-nF-YSHtSfJXYaKR4Cfe7MRJRu0bkaya-2YsraMaXJW0dPSgmNSH8d-maujzs0L3K-0NpCwMgvQ46zOxSx5P-W2lhL18asN"
}

extension TCBFirebaseClient: TCBFirebaseService {
    func sendPaymentNotification(userId: String,
                                 completion: @escaping TCBResponseCompletion<FirebaseMessage>) {
        
        guard let url = URL(string: host + path) else {
            completion(.error(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("key=\(key)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
       
        let body: [String: Any] = ["to": "/topics/\(userId)",
                                   "data": ["title": "You have received a payment",
                                            "message": ""]]
        
        if let theJSONData = try?  JSONSerialization.data(withJSONObject: body,
                                                          options: .prettyPrinted) {
            urlRequest.httpBody = theJSONData
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let data = data,
                  let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                if let error = error {
                    completion(.error(error))
                }
                return
            }
            
            let message = FirebaseMessage(messageId: (jsonData["message_id"] as? Int64) ?? 0)
            completion(.success(message))
        }
        task.resume()
    }
}
