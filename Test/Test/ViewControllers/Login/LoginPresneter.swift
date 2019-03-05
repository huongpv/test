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
    
    func login(email: String, password: String, calback: @escaping (_ user: String?, _ error: Error?) -> Void) {
        loginViewProtocol?.startLoading()
        diaryService.login(email: email, password: password) { (uid, error) in
            self.loginViewProtocol?.finishLoading()
            if let error = error {
                calback(nil, error)
            } else if let uid = uid {
                SharedData.accessToken = uid
                self.getDiariesFromServer(uid: uid)
                calback(uid, nil)
            }
        }
    }
    
    // when login success then save diaries to database
    private func getDiariesFromServer(uid: String) {
        //loginViewProtocol?.startLoading()
        diaryService.getDiariesFromServer(uid: uid) { (diaries, error) in
//            self.loginViewProtocol?.finishLoading()
            if let _ = error {
                print("getDiariesFromServer Fail")
            } else if let diariesJSON = diaries, error == nil {
                self.saveDiariesToDB(objects: diariesJSON)
            }
        }
    }
    
    private func saveDiariesToDB(objects: [Diary]) {
        var diaries = [DiaryDB]()
        for item in objects {
            let diary = DiaryDB(context: CoreDataManager.shared.privateContext)
            diary.title = item.title
            diary.content = item.content
            diary.coverUrl = item.coverUrl
            diary.mood = item.mood
            diary.publishedAt = item.publishedAt?.dateBy(format: DateFormat.dateTimeWithSlash)
            diaries.append(diary)
        }
        
        CoreDataManager.shared.add(objects: diaries)
    }

}
