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
        
        let backgroundImage = UIImage(named: SharedData.backgroundImage ?? "login-mohini")
        view.backgroundColor = UIColor(patternImage: backgroundImage ?? UIImage())

        loginPresenter.attachViewController(self)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let email = "huongpv37@gmail.com"// txtEmail.text ?? ""
        let password = "Vanhuong90"// txtPassword.text ?? ""
        
        loginPresenter.login(email: email, password: password) { (error) in
            if let error = error {
                UIAlertController.showQuickSystemAlert(target: self, title: "Thông báo", message: "Lỗi sai tài khoản hoặc mật khẩu \(error)", cancelButtonTitle: "Ok", handler: nil)
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
