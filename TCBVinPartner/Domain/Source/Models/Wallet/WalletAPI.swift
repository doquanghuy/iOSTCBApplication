//
//  WalletAPI.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 10/2/20.
//

import Foundation

open class WalletAPI {
    /**

     - examples: [{contentType=application/json, example={
      "unstructuredData" : [ {
        "value" : "value",
        "key" : "key"
      }, {
        "value" : "value",
        "key" : "key"
      } ],
      "walletEntries" : [ {
        "bankAccount" : {
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
          "bankCode" : "bankCode",
          "displayNumber" : "displayNumber",
          "issuerName" : "issuerName",
          "active" : true,
          "bankName" : "bankName",
          "type" : 4,
          "accountNumber" : "accountNumber",
          "limitSetId" : 7,
          "accountHolderName" : "accountHolderName",
          "bankCountry" : "bankCountry",
          "bankCity" : "bankCity",
          "branchCode" : "branchCode",
          "issuerId" : 2,
          "lastUpdate" : "2000-01-23T04:56:07.000+00:00",
          "customerId" : 9,
          "currency" : "currency",
          "id" : 7,
          "multiCurrency" : true,
          "hash" : "hash",
          "status" : 3
        },
        "creditPriority" : 5,
        "offlineSva" : {
          "shared" : true,
          "creator" : 7,
          "issuerName" : "issuerName",
          "lastUpdater" : 4,
          "active" : true,
          "merchant" : 1,
          "description" : "description",
          "lastSyncDate" : "2000-01-23T04:56:07.000+00:00",
          "type" : 4,
          "balanceAmount" : 6,
          "creationDate" : "2000-01-23T04:56:07.000+00:00",
          "limitSetId" : 0,
          "issuerId" : 3,
          "default" : true,
          "svaCode" : "svaCode",
          "offlineSVAStatusId" : 4,
          "lastUpdate" : "2000-01-23T04:56:07.000+00:00",
          "customerId" : 7,
          "currency" : "currency",
          "id" : 3,
          "multiCurrency" : true,
          "hash" : "hash",
          "status" : 5
        },
        "debitPriority" : 5,
        "customerId" : 6,
        "alias" : "alias",
        "externalAccount" : {
          "issuerName" : "issuerName",
          "active" : true,
          "type" : 3,
          "limitSetId" : 6,
          "issuerId" : 6,
          "id2" : "id2",
          "id1" : "id1",
          "customerId" : 8,
          "id4" : "id4",
          "id3" : "id3",
          "currency" : "currency",
          "id6" : "id6",
          "id" : 6,
          "id5" : "id5",
          "id8" : "id8",
          "id7" : "id7",
          "multiCurrency" : true,
          "hash" : "hash",
          "status" : 9
        },
        "paymentInstrumentId" : 1,
        "id" : 0,
        "creditCard" : {
          "securityNumber" : "securityNumber",
          "cardIssueNumber" : 9,
          "displayNumber" : "displayNumber",
          "cardHolderName" : "cardHolderName",
          "issuerName" : "issuerName",
          "cardType" : 4,
          "active" : true,
          "type" : 7,
          "yearExpiry" : 5,
          "limitSetId" : 1,
          "monthExpiry" : 9,
          "issuerId" : 6,
          "customerId" : 1,
          "currency" : "currency",
          "id" : 1,
          "multiCurrency" : true,
          "hash" : "hash",
          "cardNumber" : "cardNumber",
          "status" : 1
        },
        "limitSetId" : 2,
        "sva" : {
          "debitBalance" : 7,
          "type" : 5,
          "refundInTransaction" : true,
          "lastBookingDate" : "2000-01-23T04:56:07.000+00:00",
          "issuerId" : 6,
          "customerId" : 2,
          "maxBalance" : 6,
          "refundAbsoluteAmount" : 4,
          "currency" : "currency",
          "id" : 1,
          "multiCurrency" : true,
          "debitReserved" : 0,
          "creditReserved" : 3,
          "issuerName" : "issuerName",
          "active" : true,
          "limitSetId" : 6,
          "creditBalance" : 3,
          "minBalance" : 0,
          "refundTargetAmount" : 7,
          "refundThreshold" : 3,
          "refundPaymentInstrumentId" : 8,
          "lastSvaBookingId" : 7,
          "hash" : "hash",
          "status" : 6
        }
      }, {
        "bankAccount" : {
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
          "bankCode" : "bankCode",
          "displayNumber" : "displayNumber",
          "issuerName" : "issuerName",
          "active" : true,
          "bankName" : "bankName",
          "type" : 4,
          "accountNumber" : "accountNumber",
          "limitSetId" : 7,
          "accountHolderName" : "accountHolderName",
          "bankCountry" : "bankCountry",
          "bankCity" : "bankCity",
          "branchCode" : "branchCode",
          "issuerId" : 2,
          "lastUpdate" : "2000-01-23T04:56:07.000+00:00",
          "customerId" : 9,
          "currency" : "currency",
          "id" : 7,
          "multiCurrency" : true,
          "hash" : "hash",
          "status" : 3
        },
        "creditPriority" : 5,
        "offlineSva" : {
          "shared" : true,
          "creator" : 7,
          "issuerName" : "issuerName",
          "lastUpdater" : 4,
          "active" : true,
          "merchant" : 1,
          "description" : "description",
          "lastSyncDate" : "2000-01-23T04:56:07.000+00:00",
          "type" : 4,
          "balanceAmount" : 6,
          "creationDate" : "2000-01-23T04:56:07.000+00:00",
          "limitSetId" : 0,
          "issuerId" : 3,
          "default" : true,
          "svaCode" : "svaCode",
          "offlineSVAStatusId" : 4,
          "lastUpdate" : "2000-01-23T04:56:07.000+00:00",
          "customerId" : 7,
          "currency" : "currency",
          "id" : 3,
          "multiCurrency" : true,
          "hash" : "hash",
          "status" : 5
        },
        "debitPriority" : 5,
        "customerId" : 6,
        "alias" : "alias",
        "externalAccount" : {
          "issuerName" : "issuerName",
          "active" : true,
          "type" : 3,
          "limitSetId" : 6,
          "issuerId" : 6,
          "id2" : "id2",
          "id1" : "id1",
          "customerId" : 8,
          "id4" : "id4",
          "id3" : "id3",
          "currency" : "currency",
          "id6" : "id6",
          "id" : 6,
          "id5" : "id5",
          "id8" : "id8",
          "id7" : "id7",
          "multiCurrency" : true,
          "hash" : "hash",
          "status" : 9
        },
        "paymentInstrumentId" : 1,
        "id" : 0,
        "creditCard" : {
          "securityNumber" : "securityNumber",
          "cardIssueNumber" : 9,
          "displayNumber" : "displayNumber",
          "cardHolderName" : "cardHolderName",
          "issuerName" : "issuerName",
          "cardType" : 4,
          "active" : true,
          "type" : 7,
          "yearExpiry" : 5,
          "limitSetId" : 1,
          "monthExpiry" : 9,
          "issuerId" : 6,
          "customerId" : 1,
          "currency" : "currency",
          "id" : 1,
          "multiCurrency" : true,
          "hash" : "hash",
          "cardNumber" : "cardNumber",
          "status" : 1
        },
        "limitSetId" : 2,
        "sva" : {
          "debitBalance" : 7,
          "type" : 5,
          "refundInTransaction" : true,
          "lastBookingDate" : "2000-01-23T04:56:07.000+00:00",
          "issuerId" : 6,
          "customerId" : 2,
          "maxBalance" : 6,
          "refundAbsoluteAmount" : 4,
          "currency" : "currency",
          "id" : 1,
          "multiCurrency" : true,
          "debitReserved" : 0,
          "creditReserved" : 3,
          "issuerName" : "issuerName",
          "active" : true,
          "limitSetId" : 6,
          "creditBalance" : 3,
          "minBalance" : 0,
          "refundTargetAmount" : 7,
          "refundThreshold" : 3,
          "refundPaymentInstrumentId" : 8,
          "lastSvaBookingId" : 7,
          "hash" : "hash",
          "status" : 6
        }
      } ],
      "conversationId" : "conversationId",
      "status" : {
        "code" : 0,
        "value" : "value"
      }
    }}]
     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getWalletEntriesByCustomer(body: GetWalletEntriesRequest? = nil, completion: @escaping (Result<GetWalletEntriesResponse, Error>) -> Void) {
        /*
        let headers: HTTPHeaders = ["Accept": "application/json", "Content-Type": "application/json", "Cookie": "\(ClientAPI.cookie)"]
        
        let path = "/getWalletEntriesByCustomer"
        
        
        AF.request(ClientAPI.basePath + path, method: .post, parameters: body, encoder: JSONParameterEncoder.default, headers: headers).responseJSON { response in
            guard let data = response.data else {return}
            do {
                let json = try JSONDecoder().decode(GetWalletEntriesResponse.self, from: data)
                completion(.success(json))
            } catch let error{
                completion(.failure(error))
            }
        }
         */
    }
    
    open class func getWalletEntriesTCBCustomer(body: GetWalletEntriesRequest? = nil, completion: @escaping (Result<GetWalletEntriesResponse, Error>) -> Void) {
        /*
        let path = "/getWalletEntriesByCustomer"
        let Url = String(format: ClientAPI.basePath + path)
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Application/json", forHTTPHeaderField: "Accept")
        request.setValue(ClientAPI.cookie, forHTTPHeaderField: "Cookie")
        guard let httpBody = try? JSONEncoder().encode(body) else {
            return
        }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(GetWalletEntriesResponse.self, from: data)
                    print(json)
                    completion(.success(json))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()
         */
    }

}
