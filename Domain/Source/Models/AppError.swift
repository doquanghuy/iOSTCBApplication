//
//  AppError.swift
//  TCBPay
//
//  Created by Dinh Duong on 9/10/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import Foundation

public enum AppError: Error {
    case any
    case notConnectToServer
    case wrongCredentials
    case unknown
}
