//
//  SystemBoots.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit

class SystemBoots {
    
    // MARK: - Singleton
    static let instance = SystemBoots()
    
    // MARK: - Variables
    weak var appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
}
