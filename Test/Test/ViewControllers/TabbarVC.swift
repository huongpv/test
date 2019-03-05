//
//  TabbarVC.swift
//  Test
//
//  Created by Macbook on 3/1/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

enum TabbarItem: Int {
    case diary
    case work
    case myPage
    case login
    
    static let arrayTitle = [diary: "Diary",
                             work: "Work",
                             myPage: "MyPage"]
    
    static let arrayTag = [ diary: 0,
                            work: 1,
                            myPage: 2]
    func getTitle() -> String {
        return TabbarItem.arrayTitle[self] ?? ""
    }
    
    func getTag() -> Int {
        return TabbarItem.arrayTag[self] ?? 0
    }
}

class TabbarVC: UITabBarController {
    lazy var diaryVC = DiaryVC()
    lazy var workVC = WorkVC()
    lazy var myPageVC = MyPageVC()
    lazy var diaryNav = createNavigationItem(rootVC: diaryVC, itemTitle: TabbarItem.diary.getTitle(), itemTag: TabbarItem.diary.getTag())
    lazy var workNav = createNavigationItem(rootVC: workVC, itemTitle: TabbarItem.work.getTitle(), itemTag: TabbarItem.work.getTag())
    lazy var myPageNav = createNavigationItem(rootVC: myPageVC, itemTitle: TabbarItem.myPage.getTitle(), itemTag: TabbarItem.myPage.getTag())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 15)!], for: .normal)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -15)
        
        viewControllers = [diaryNav, workNav, myPageNav]
    }
    
    func createNavigationItem(rootVC: UIViewController, itemTitle: String, itemTag: Int) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootVC)
        nav.tabBarItem = UITabBarItem(title: itemTitle, image: nil, tag: itemTag)
        
        return nav
    }
    
}
