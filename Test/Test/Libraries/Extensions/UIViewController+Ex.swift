//
//  UIViewController+Ex.swift
//  Test
//
//  Created by Macbook on 3/1/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    func setupPlusButtonInNavBar(selector: Selector) {
        let rightBarItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: selector)
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func setupSaveButtonInNavBar(selector: Selector) {
        let rightBarItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: selector)
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func setupCancelButtonInNavBar() {
        let leftBarItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem = leftBarItem
    }
    
    @objc private func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func setViewBackgroundColor() {
        let backgroundImage = UIImage(named: SharedData.backgroundImage ?? "wallpaper")
        view.backgroundColor = UIColor(patternImage: backgroundImage ?? UIImage())
    }
}
