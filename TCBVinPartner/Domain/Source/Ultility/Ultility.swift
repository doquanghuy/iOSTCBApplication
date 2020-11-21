//
//  Ultility.swift
//  Domain
//
//  Created by vuong on 10/16/20.
//

import Foundation

// MARK: - Protocol wrapper
public protocol TCBAutoEncodable: Encodable {}
public protocol TCBAutoDecodable: Decodable {}
public protocol TCBAutoCodable: TCBAutoDecodable & TCBAutoEncodable {}

public typealias TCBResponseCompletion <T: Codable> = ((_ response: TCBResult<T>) -> Void)

public enum TCBResult<T: Codable> {
    case success(T?)
    case error(Error)
}
