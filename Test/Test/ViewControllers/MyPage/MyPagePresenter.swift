//
//  MyPagePresenter.swift
//  Test
//
//  Created by Macbook on 3/5/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

protocol MyPageProtocol: BaseProtocol {
    
}

class MyPagePresenter {
    private let diaryService: DiaryService
    weak private var myPageViewProtocol: MyPageProtocol?
    
    init(diaryService: DiaryService) {
        self.diaryService = diaryService
    }
    
    func attachViewController(_ viewController: MyPageProtocol){
        myPageViewProtocol = viewController
    }
    
    func detachView() {
        myPageViewProtocol = nil
    }
    
    func logout(calback: @escaping (_ error: Error?) -> Void) {
        myPageViewProtocol?.startLoading()
        diaryService.logout { (error) in
            self.myPageViewProtocol?.finishLoading()
            if let error = error {
                calback(error)
            } else {
                // remove all data
                CoreDataManager.shared.delete(type: DiaryDB.self)
                
                // reset isSyncData
                SharedData.isSyncData = nil
                
                // reset accessToken
                SharedData.accessToken = nil
                calback(nil)
            }
        }
    }
    
}
