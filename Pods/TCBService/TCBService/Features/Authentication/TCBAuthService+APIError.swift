//
//  TCBAuthService+APIError.swift
//  TCBService
//
//  Created by Huy TO. Nguyen Van on 10/30/20.
//

import Foundation

public extension Error {
    var message: String {
        print(self)
        if let self = self as? APIError {
            return self._message
        } else if (self as NSError).code == -1009 {
            return "The connection appears to be offline."
        }
        return "Something wrong occured ! Please try again later."
    }
}

public enum APIError: Error {
    case unknown
    case urlError
    case tokenExpired
    case errorMessage(_ message: String)
    
    public var _message: String {
        switch self {
        case .unknown:
            return "Something wrong occured ! Please try again later."
        case .urlError:
            return "A malformed URL prevented a URL request from being initiated."
        case .tokenExpired:
            return "Token expired"
        case .errorMessage(let message):
            return message
        }
    }
}
