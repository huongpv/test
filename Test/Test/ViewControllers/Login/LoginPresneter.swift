//
//  LoginPresneter.swift
//  Test
//
//  Created by Macbook on 3/3/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

protocol LoginProtocol: BaseProtocol {

}

class LoginPresenter {
    private let diaryService: DiaryService
    weak private var loginViewProtocol: LoginProtocol?
    
    init(diaryService: DiaryService) {
        self.diaryService = diaryService
    }
    
    func attachViewController(_ viewController: LoginProtocol){
        loginViewProtocol = viewController
    }
    
    func detachView() {
        loginViewProtocol = nil
    }
    
    func login(email: String, password: String, calback: @escaping (_ error: Error?) -> Void) {
        loginViewProtocol?.startLoading()
        diaryService.login(email: email, password: password) { (user, error) in
            self.loginViewProtocol?.finishLoading()
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
