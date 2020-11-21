//
//  UserAPI.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 9/30/20.
//

import Foundation

open class UserAPI {
    
    /**
     Log in
     - POST /loginTcbCustomer
        
     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects

     - examples: [{contentType=application/json, example={
      "sessionTimeoutSeconds" : 7,
      "privileges" : [ "privileges", "privileges" ],
      "unstructuredData" : [ {
        "value" : "value",
        "key" : "key"
      }, {
        "value" : "value",
        "key" : "key"
      } ],
      "conversationId" : "conversationId",
      "sessionId" : "sessionId",
      "status" : {
        "code" : 0,
        "value" : "value"
      },
      "customer" : {
        "country" : "country",
        "spareFields" : {
          "spareCLOB1" : "spareCLOB1",
          "spareBoolean5" : true,
          "spareBoolean1" : true,
          "spareBoolean2" : true,
          "spareBoolean3" : true,
          "spareBoolean4" : true,
          "spareString6" : "spareString6",
          "spareDate1" : "2000-01-23T04:56:07.000+00:00",
          "spareString7" : "spareString7",
          "spareDate2" : "2000-01-23T04:56:07.000+00:00",
          "spareString4" : "spareString4",
          "spareDate3" : "2000-01-23T04:56:07.000+00:00",
          "spareString5" : "spareString5",
          "spareDate4" : "2000-01-23T04:56:07.000+00:00",
          "spareString2" : "spareString2",
          "spareString3" : "spareString3",
          "spareString1" : "spareString1",
          "spareInteger4" : 1,
          "spareInteger3" : 1,
          "spareInteger5" : 6,
          "spareInteger2" : 1,
          "spareString10" : "spareString10",
          "spareInteger1" : 7,
          "spareDate5" : "2000-01-23T04:56:07.000+00:00",
          "spareString8" : "spareString8",
          "spareString9" : "spareString9"
        },
        "blackListReason" : 5,
        "test" : true,
        "securityQuestion" : "securityQuestion",
        "securityAnswer" : "securityAnswer",
        "displayName" : "displayName",
        "created" : "2000-01-23T04:56:07.000+00:00",
        "active" : true,
        "timeZone" : "timeZone",
        "language" : "language",
        "dateOfBirth" : "2000-01-23T04:56:07.000+00:00",
        "cancellationReasonId" : 7,
        "limitSetId" : 2,
        "parentId" : 1,
        "feeSetId" : 3,
        "customerTypeId" : 2,
        "riskCategoryId" : 5,
        "referralCode" : "referralCode",
        "txnText" : "txnText",
        "feeVatPercentage" : 9.301444243932576,
        "id" : 6,
        "orgUnitId" : "orgUnitId",
        "txnReceiptModeId" : 4
      }
    }}]
     */
    public static var basePath = "https://m.techcombank.com.vn/mobiliser/rest/smartphone"
    
//    public static var basePath = "https://mbtest.techcombank.com.vn:8091/Mob50_port8093"
    
    open class func loginTcbCustomer(body: LoginCustomerRequest? = nil, completion: @escaping (Result<LoginCustomerResponse, Error>) -> Void) {
//        let headers: HTTPHeaders = ["Accept": "application/json", "Content-Type": "application/json"]
//
//        let path = "/loginTcbCustomer"
//        AF.request(basePath + path, method: .post, parameters: body, encoder: JSONParameterEncoder.default, headers: headers).responseJSON { response in
//            guard let data = response.data else {return}
//            do {
//                let json = try JSONDecoder().decode(LoginCustomerResponse.self, from: data)
//                completion(.success(json))
//            } catch let error{
//                completion(.failure(error))
//            }
//        }
    }

}
