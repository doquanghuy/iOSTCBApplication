//
//  TCBServiceFactory.swift
//  BackbasePlatform
//
//  Created by Son le on 10/11/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Backbase

public final class TCBServiceFactory {
    private static var services: [Any] = []

    static func initializeServices() {
        services = [
            TCBTransactionsClient(),
            Backbase.authClient(),
            TCBConfigurationClient(),
            TCBDBSClient(),
            TCBDBSProductSummaryClient(),
            TCBDBSPaymentClient(),
            TCBDBSContactClient()
        ]
    }

    public static func loadService<T>() -> T {
        guard let service = services.first(where: { $0 is T }) else {
            fatalError("Service type is not supported")
        }
        return service as! T
    }
}
