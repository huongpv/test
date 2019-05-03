//
//  AppDelegate.swift
//  Test
//
//  Created by huongpv on 12/21/18.
//  Copyright © 2018 huongpv. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().tintColor = .black
        
        // Setup Firebase
        setupFirebase()
        
        // Set root viewcontroller
        setRootViewControoler()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
    }
    
    private func setRootViewControoler() {
        var rootViewController = UIViewController()
        if let _ = SharedData.accessToken {
            rootViewController = TabbarVC()
        } else {
            let loginVC = LoginVC()
            rootViewController = UINavigationController(rootViewController: loginVC)
        }
        
        window = UIWindow()
        changeRootViewControoler(viewController: rootViewController)
    }
    
    func changeRootViewControoler(viewController: UIViewController) {
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    private func setupFirebase() {
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(fcmTokenDidRefresh),
                                               name: .InstanceIDTokenRefresh,
                                               object: nil)
    }
    
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    @objc func fcmTokenDidRefresh() {
        let fcmToken = Messaging.messaging().fcmToken
        print(fcmToken ?? "")
        // Send fcm token to server
    }
}
