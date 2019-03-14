//
//  ForgotPasswordPresenter.swift
//  Test
//
//  Created by huongpv on 3/14/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

protocol ForgotPasswordProtocol: BaseProtocol {
    
}

class ForgotPasswordPresenter {
    private let diaryService: DiaryService
    weak private var forgotPasswordViewProtocol: ForgotPasswordProtocol?
    
    init(diaryService: DiaryService) {
        self.diaryService = diaryService
    }
    
    func attachViewController(_ viewController: ForgotPasswordProtocol){
        forgotPasswordViewProtocol = viewController
    }
    
    func detachView() {
        forgotPasswordViewProtocol = nil
    }
    
    func forgotPassword(email: String, calback: @escaping (_ error: Error?) -> Void) {
        forgotPasswordViewProtocol?.startLoading()
        diaryService.forgotPassword(email: email) { (error) in
            self.forgotPasswordViewProtocol?.finishLoading()
            calback(error)
        }
    }
    
}
