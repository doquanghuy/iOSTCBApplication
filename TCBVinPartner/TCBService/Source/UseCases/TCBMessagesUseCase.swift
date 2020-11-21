//
//  TCBMessagesUseCase.swift
//  TCBService
//
//  Created by duc on 10/19/20.
//

import Domain
import NotificationsClient

class TCBMessagesUseCase: MessagesUseCase {
    private let notificationService: TCBNotificationsService

    init(notificationService: TCBNotificationsService) {
        self.notificationService = notificationService
    }

    func fetchMessages(completion: @escaping TCBResponseCompletion<[Message]>) {
        notificationService.fetchNotifications { notifications in
            completion(.success((notifications.value ?? []).map { Message(notification: $0) }))
        }
    }
}

extension Message {
    init(notification: BBNotification) {
        self.init(title: notification.level.rawValue, description: notification.title ?? "", iconName: "message_payment", amount: "")
    }
}
