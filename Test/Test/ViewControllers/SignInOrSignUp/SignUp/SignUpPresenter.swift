//
//  SignUpPresenter.swift
//  Test
//
//  Created by huongpv on 3/14/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

protocol SignUpProtocol: BaseProtocol {
    
}

class SignUpPresenter {
    private let diaryService: DiaryService
    weak private var signUpViewProtocol: SignUpProtocol?
    
    init(diaryService: DiaryService) {
        self.diaryService = diaryService
    }
    
    func attachViewController(_ viewController: SignUpProtocol){
        signUpViewProtocol = viewController
    }
    
    func detachView() {
        signUpViewProtocol = nil
    }
    
    func signup(displayName: String, email: String, password: String, calback: @escaping (_ error: Error?) -> Void) {
        signUpViewProtocol?.startLoading()
        diaryService.signup(displayName: displayName, email: email, password: password) { (user, error) in
            self.signUpViewProtocol?.finishLoading()
            if let error = error {
                calback(error)
            } else {
                let userDB = UserDB(context: CoreDataManager.shared.persistenContainer.viewContext)
                userDB.name = user?.displayName
                userDB.email = user?.email
                
                CoreDataManager.shared.add(object: userDB)
                
                // save uid to share data
                SharedData.accessToken = user?.uid
                calback(nil)
            }
        }
    }
    
}
