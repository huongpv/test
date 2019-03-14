//
//  SignUpVC.swift
//  Test
//
//  Created by huongpv on 3/13/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    // MARK: -Private
    private let signupPresenter = SignUpPresenter(diaryService: DiaryService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewBackgroundColorBy(imageNamed: "login-mohini")
        
        signupPresenter.attachViewController(self)
        
        hideKeyboardWhenTappedAround()
    }

    @IBAction func btnBackToSignIn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        let name = txtName.text
        guard let email = txtEmail.text, Helper.isValidEmail(email: email) else {
            UIAlertController.showQuickSystemAlert(target: self, title: AlertKeys.title, message: AlertKeys.emailFormat, cancelButtonTitle: AlertKeys.cancelButton, handler: nil)
            return
        }
        
        guard let password = txtPassword.text, Helper.isPasswordValid(password: password) else {
            UIAlertController.showQuickSystemAlert(target: self, title: AlertKeys.title, message: AlertKeys.passwordFormat, cancelButtonTitle: AlertKeys.cancelButton, handler: nil)
            return
        }

        signupPresenter.signup(displayName: name ?? "", email: email, password: password) { (error) in
            if let _ = error {
                UIAlertController.showQuickSystemAlert(target: self, title: AlertKeys.title, message: "Đăng kí không thành công, vui lòng đăng kí lại", cancelButtonTitle: AlertKeys.cancelButton, handler: nil)
            } else {
                let tabbarVC = TabbarVC()
                SystemBoots.instance.appDelegate?.changeRootViewControoler(viewController: tabbarVC)
            }
        }

    }
}

extension SignUpVC: SignUpProtocol {
    func startLoading() {
        IndicatorViewer.show()
    }
    
    func finishLoading() {
        IndicatorViewer.hide()
    }
    
    
}
