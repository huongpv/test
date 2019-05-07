//
//  LoginVC.swift
//  Test
//
//  Created by Macbook on 3/1/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    // MARK: -Private
    private let loginPresenter = LoginPresenter(diaryService: DiaryService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewBackgroundColorBy(imageNamed: "login-mohini")

        loginPresenter.attachViewController(self)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        guard let email = txtEmail.text, Helper.isValidEmail(email: email) else {
            UIAlertController.showQuickSystemAlert(target: self, title: AlertKeys.title, message: AlertKeys.emailFormat, cancelButtonTitle: AlertKeys.cancelButton, handler: nil)
            return
        }
        
        guard let password = txtPassword.text, Helper.isPasswordValid(password: password) else {
            UIAlertController.showQuickSystemAlert(target: self, title: AlertKeys.title, message: AlertKeys.passwordFormat, cancelButtonTitle: AlertKeys.cancelButton, handler: nil)
            return
        }
        
        loginPresenter.login(email: email, password: password) { (error) in
            if let _ = error {
                UIAlertController.showQuickSystemAlert(target: self, title: AlertKeys.title, message: "Account or password error", cancelButtonTitle: AlertKeys.cancelButton, handler: nil)
            } else {
                let tabbarVC = TabbarVC()
                SystemBoots.instance.appDelegate?.changeRootViewControoler(viewController: tabbarVC)
            }
        }
    
    }
    
    @IBAction func btnToForgotPassword(_ sender: Any) {
        let forgotPasswordVC = ForgotPasswordVC()
        VCService.present(controller: forgotPasswordVC)
    }
    
    @IBAction func btnToSignUp(_ sender: Any) {
        let signUpVC = SignUpVC()
        VCService.present(controller: signUpVC)
    }
}

extension LoginVC: LoginProtocol {
    func startLoading() {
        IndicatorViewer.show()
    }
    
    func finishLoading() {
        IndicatorViewer.hide()
    }
    
}
