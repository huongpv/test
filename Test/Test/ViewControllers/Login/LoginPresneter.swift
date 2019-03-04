//
//  LoginPresneter.swift
//  Test
//
//  Created by Macbook on 3/3/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation
import CoreData

protocol LoginProtocol: class {
    func startLoading()
    func finishLoading()
}

class LoginPresenter {
    private let diaryService: DiaryService
    weak private var loginViewProtocol: CreateDiaryProtocol?
    
    init(diaryService: DiaryService) {
        self.diaryService = diaryService
    }
    
    func attachViewController(_ viewController: CreateDiaryProtocol){
        loginViewProtocol = viewController
    }
    
    func detachView() {
        loginViewProtocol = nil
    }
    
    func login(email: String, password: String, calback: @escaping (_ user: String?, _ error: Error?) -> Void) {
        loginViewProtocol?.startLoading()
        diaryService.login(email: email, password: password) { (uid, error) in
            if let error = error {
                calback(nil, error)
            } else if let uid = uid {
                SharedData.accessToken = uid
                self.getDiariesFromServer(uid: uid)
                calback(uid, nil)
            }
        }
    }
    
    private func getDiariesFromServer(uid: String) {
        loginViewProtocol?.startLoading()
        diaryService.getDiariesFromServer(uid: uid) { (diaries, error) in
            if let _ = error {
                print("getDiariesFromServer Fail")
            } else if let diaries = diaries, error == nil {
                CoreDataManager.shared.addData(objects: diaries)
            }
        }
    }

}
