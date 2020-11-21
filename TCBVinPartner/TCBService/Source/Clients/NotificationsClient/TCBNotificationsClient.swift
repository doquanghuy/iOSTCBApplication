//
//  TCBNotificationClient.swift
//  Alamofire
//
//  Created by duc on 10/19/20.
//

import NotificationsClient

class TCBNotificationsClient {
    private let client: NotificationsClient

    init() {
        let provider = TCBNotificationsDataProvider(type: .local())
        client = NotificationsClient(dataProvider: provider)
    }
}

extension TCBNotificationsClient: TCBNotificationsService {
    func fetchNotifications(_ completion: @escaping (TCBResult<[BBNotification]>) -> Void) {
        client.retrieveNotifications(with: nil) { notifications, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(notifications ?? []))
            }
        }
    }
}

// MARK: - Backbase TransactionsClient class extension
extension NotificationsClient: BBAppClient {
    typealias EnvironmentDataProvider = TCBNotificationsDataProvider
}

