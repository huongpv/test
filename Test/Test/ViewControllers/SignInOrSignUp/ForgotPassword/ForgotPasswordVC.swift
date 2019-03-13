//
//  ForgotPasswordVC.swift
//  Test
//
//  Created by huongpv on 3/13/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImage(named: SharedData.backgroundImage ?? "login-mohini")
        view.backgroundColor = UIColor(patternImage: backgroundImage ?? UIImage())
    }

    @IBAction func btnForgetPassword(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
