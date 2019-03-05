//
//  MyPageVC.swift
//  Test
//
//  Created by Macbook on 3/1/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

class MyPageVC: UIViewController {
    
    // MARK: -Outlets
    @IBOutlet weak var lbName: UILabel!
    
    // MARK: -Private
    private let myPagePresenter = MyPagePresenter(diaryService: DiaryService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myPagePresenter.attachViewController(self)
    }
    
    @IBAction func btnLogout(_ sender: Any) {
        myPagePresenter.logout { (error) in
            if let error = error {
                print("Logout: \(error.localizedDescription)")
            } else {
                let tabbarVC = LoginVC()
                SystemBoots.instance.appDelegate?.changeRootViewControoler(viewController: tabbarVC)
            }
        }
    }
    
}

extension MyPageVC: MyPageProtocol {
    func startLoading() {
        IndicatorViewer.show()
    }
    
    func finishLoading() {
        IndicatorViewer.hide()
    }
    
}
