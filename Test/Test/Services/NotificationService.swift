//
//  NotificationService.swift
//  TetViet
//
//  Created by vinhdd on 12/14/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftyJSON

class NotificationService: NSObject {
    
    // MARK: - Singleton
    static var instance = NotificationService()
    
    // Cache push notification data to show (when app is killed or not being opened)
    var launchRemoteData: [AnyHashable : Any]?
    
    // MARK: - Register push notification
    func registerPushNotification(application: UIApplication = UIApplication.shared, completion: (() -> Void)? = nil) {
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { granted, error in
                DispatchQueue.main.async {
                    if error == nil && granted {
                        application.registerForRemoteNotifications()
                    }
                    completion?()
                }
            })
            UNUserNotificationCenter.current().delegate = self
        } else {
            let notificationSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            application.registerUserNotificationSettings(notificationSettings)
            application.registerForRemoteNotifications()
            completion?()
        }
    }
    
    // MARK: - Supporting methods
    func getDeliveredNotificationsCount(completion: @escaping ((_ count: Int) -> Void)) {
        UNUserNotificationCenter.current().getDeliveredNotifications(completionHandler: { (notifications) in
            DispatchQueue.main.async {
                completion(notifications.count)
            }
        })
    }
    
    func removeAllLocalNotifications(removeDelivered: Bool = false, completion: @escaping (() -> Void)) {
        let application = UIApplication.shared
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.getPendingNotificationRequests(completionHandler: { requests in
                DispatchQueue.main.async {
                    let removeIds = requests.map({ $0.identifier })
                    center.removePendingNotificationRequests(withIdentifiers: removeIds)
                    print("[Local Notification] Removed all ! (iOS >= 10)")
                    completion()
                }
            })
            if removeDelivered {
                center.getDeliveredNotifications(completionHandler: { notifications in
                    DispatchQueue.main.async {
                        let removeIds = notifications.map { $0.request.identifier }
                        center.removeDeliveredNotifications(withIdentifiers: removeIds)
                    }
                })
            }
        } else {
            if let localNotis = application.scheduledLocalNotifications {
                localNotis.forEach {
                    application.cancelLocalNotification($0)
                }
                print("[Local Notification] Removed all ! (iOS < 10)")
            }
            completion()
        }
    }
    
    func removeLocalNotificationsWith(identifier: String,
                                      removeDelivered: Bool = false,
                                      completion: @escaping (() -> Void)) {
        let application = UIApplication.shared
        let identifierKey = "Identifier"
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            func removeDeliveredIfNeeded() {
                if removeDelivered {
                    center.getDeliveredNotifications(completionHandler: { notifications in
                        DispatchQueue.main.async {
                            var removeIds = [String]()
                            for noti in notifications {
                                let request = noti.request
                                if let id = request.content.userInfo[identifierKey] as? String, id == identifier {
                                    removeIds.append(request.identifier)
                                }
                            }
                            center.removeDeliveredNotifications(withIdentifiers: removeIds)
                            completion()
                        }
                    })
                } else { completion() }
            }
            center.getPendingNotificationRequests(completionHandler: { requests in
                DispatchQueue.main.async {
                    let removeIds = requests.filter({
                        if let id = $0.content.userInfo[identifierKey] as? String {
                            return id == identifier
                        }
                        return false
                    }).map({ $0.identifier })
                    center.removePendingNotificationRequests(withIdentifiers: removeIds)
                    print("[Local Notification][Type: \(identifier)] Removed all ! (iOS >= 10)")
                    if removeDelivered { removeDeliveredIfNeeded() }
                    else { completion() }
                }
            })
        } else {
            if let localNotifications = application.scheduledLocalNotifications {
                let targetList = localNotifications.filter({
                    if let id = $0.userInfo?[identifierKey] as? String {
                        return id == identifier
                    }
                    return false
                })
                targetList.forEach {
                    application.cancelLocalNotification($0)
                }
                print("[Local Notification][Type: \(identifier)] Removed all ! (iOS < 10)")
            }
            completion()
        }
    }
}

// MARK: - Handle device token
extension NotificationService {
    func parseDeviceToken(data: Data) {
        let deviceToken = data.reduce("", {$0 + String(format: "%02X", $1)})
        SharedData.deviceToken = deviceToken
        sendDeviceTokenToServer(deviceToken: deviceToken)
    }
    
    func sendDeviceTokenToServer(deviceToken: String, completion: (() -> Void)? = nil) {
        print("[PUSH NOTIFICATION] - Device Token: \(deviceToken)")
        // TODO: - Send device token to server
    }
}

// MARK: - Handle push notification & local notification data
extension NotificationService {
    // MARK: - Receive data from remote & local notifications
    func received(notification userInfo: [AnyHashable: Any], application: UIApplication, isRemoteNoti: Bool) {
        // Write your code
        let json = JSON(userInfo)
        navigateNotiToApp(json: json)
    }
}

@available(iOS 10.0, *)
extension NotificationService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Check if this is a local notification or remote notification
        var isRemoteNoti = false
        if let trigger = response.notification.request.trigger, trigger.isKind(of: UNPushNotificationTrigger.self) {
            // User did tap at remote notification
            isRemoteNoti = true
        }
        received(notification: response.notification.request.content.userInfo, application: UIApplication.shared, isRemoteNoti: isRemoteNoti)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let jsonData = JSON(notification.request.content.userInfo)
        print("[USER NOTIFICATION CENTER] - Received response:\n\(jsonData)\n")
        // TODO: Check if you need to show notification alert or not by calling completionHandler
        completionHandler([.alert, .badge, .sound])
    }
    
    private func navigateNotiToApp(json: JSON) {
        let remoteNoti = RemoteNoti(json: json)
        
        print(remoteNoti)
    }
}
