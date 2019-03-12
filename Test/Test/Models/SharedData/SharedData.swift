//
//  SharedData.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

// MARK: - General information
class SharedData {

    // Access token for requesting APIs
    class var accessToken: String? {
        get {
            return (UserDefaults.standard.value(forKey: "ApiAccessToken") as? String)?.decryptAES
        }
        set(value) {
            UserDefaults.standard.set(value?.encryptAES, forKey: "ApiAccessToken")
        }
    }
    
    // APNS token is saved in app
    class var deviceToken: String? {
        get {
            return (UserDefaults.standard.value(forKey: "NotificationToken") as? String)?.decryptAES
        }
        set(value) {
            UserDefaults.standard.set(value?.encryptAES, forKey: "NotificationToken")
        }
    }
    
    class var isSyncData: Bool? {
        get {
            return (UserDefaults.standard.value(forKey: "isSyncData") as? Bool)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "isSyncData")
        }
    }
    
    class var fontName: String? {
        get {
            return (UserDefaults.standard.value(forKey: "fontName") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "fontName")
        }
    }
    
    class var backgroundImage: String? {
        get {
            return (UserDefaults.standard.value(forKey: "backgroundImage") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "backgroundImage")
        }
    }
}
