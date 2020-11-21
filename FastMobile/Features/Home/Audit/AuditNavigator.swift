//
//  AuditNavigator.swift
//  FastMobile
//
//  Created by Duong Dinh on 11/16/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import Domain

protocol AuditNavigator {
    
}

class DefaultAuditNavigator: AuditNavigator {
    
    private let navigationController: UINavigationController?
    private let services: AuditUseCase

    init(services: AuditUseCase,
         navigationController: UINavigationController?) {
        self.services = services
        self.navigationController = navigationController
    }
}
