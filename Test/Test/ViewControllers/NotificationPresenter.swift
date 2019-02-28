//
//  NotificationPresenter.swift
//  Test
//
//  Created by huongpv on 2/28/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

protocol NotificationProtocol: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setNotifications(_ notifications: [Notification])
}

class NotificationPresenter {
    private let notificationService: NotificationService
    weak private var notificationViewProtocol: NotificationProtocol?
    
    init(notificationService: NotificationService) {
        self.notificationService = notificationService
    }
    
    func attachViewController(_ viewController: NotificationProtocol){
        notificationViewProtocol = viewController
    }
    
    func detachView() {
        notificationViewProtocol = nil
    }
    
    func getNotifications() {
        notificationViewProtocol?.startLoading()
        notificationService.getNotificationServices { [weak self] notifications in
            self?.notificationViewProtocol?.finishLoading()
            self?.notificationViewProtocol?.setNotifications(notifications)
        }
    }
}
