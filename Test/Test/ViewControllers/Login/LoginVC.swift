//
//  LoginVC.swift
//  Test
//
//  Created by Macbook on 3/1/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    @IBAction func btnLogin(_ sender: Any) {
        let email = txtEmail.text ?? ""
        let password = txtPassword.text ?? ""
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                UIAlertController.showQuickSystemAlert(target: self, title: "Thông báo", message: "Lỗi sai tài khoản hoặc mật khẩu \(error)", cancelButtonTitle: "Ok", handler: nil)
            } else if let user = authResult?.user {
                UIAlertController.showQuickSystemAlert(target: self, title: "Thông báo", message: "Đăng nhập thành công \(user.email ?? "")", cancelButtonTitle: "Ok", handler: nil)
            }
        }
    }
    
}
