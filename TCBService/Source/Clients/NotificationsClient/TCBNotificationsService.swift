//
//  TCBNotificationService.swift
//  Alamofire
//
//  Created by duc on 10/19/20.
//

import NotificationsClient

protocol TCBNotificationsService {
    func fetchNotifications(_ completion: @escaping (TCBResult<[BBNotification]>) -> Void)
}
