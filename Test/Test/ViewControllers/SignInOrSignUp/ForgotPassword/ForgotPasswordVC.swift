//
//  ForgotPasswordVC.swift
//  Test
//
//  Created by huongpv on 3/13/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var imgForget: UIImageView!
    // MARK: -Private
    private let forgotPasswordPresenter = ForgotPasswordPresenter(diaryService: DiaryService())

    override func viewDidLoad() {
        super.viewDidLoad()

        imgForget.layer.cornerRadius = 5
        imgForget.layer.masksToBounds = true
        
        setViewBackgroundColorBy(imageNamed: "login-mohini")
        
        forgotPasswordPresenter.attachViewController(self)
    }

    @IBAction func btnForgetPassword(_ sender: Any) {
        guard let email = txtEmail.text, Helper.isValidEmail(email: email) else {
            UIAlertController.showQuickSystemAlert(target: self, title: AlertKeys.title, message: AlertKeys.emailFormat, cancelButtonTitle: AlertKeys.cancelButton, handler: nil)
            return
        }
        
        forgotPasswordPresenter.forgotPassword(email: email) { (error) in
            var message = ""
            if let _ = error {
                message = "Lỗi phát sinh vui lòng thử lại"
                print("Error \(error?.localizedDescription ?? "")")
            } else {
                message = "Hệ thông đã gửi cho bạn email để lấy lại mật khẩu"
            }
            
            UIAlertController.showQuickSystemAlert(target: self, title: AlertKeys.title, message: message, cancelButtonTitle: AlertKeys.cancelButton, handler: {
                self.dismiss(animated: true, completion: nil)
            })
            
        }
        
    }
    
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ForgotPasswordVC: ForgotPasswordProtocol {
    func startLoading() {
        IndicatorViewer.show()
    }
    
    func finishLoading() {
        IndicatorViewer.hide()
    }
    
    
}
