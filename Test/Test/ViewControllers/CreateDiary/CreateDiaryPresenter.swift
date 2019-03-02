//
//  CreateDiaryPresenter.swift
//  Test
//
//  Created by Macbook on 3/2/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

protocol CreateDiaryProtocol: class {
    func startLoading()
    func finishLoading()
}

class CreateDiaryPresenter {
    private let diaryService: DiaryService
    weak private var createDiaryViewProtocol: CreateDiaryProtocol?
    
    init(diaryService: DiaryService) {
        self.diaryService = diaryService
    }
    
    func attachViewController(_ viewController: CreateDiaryProtocol){
        createDiaryViewProtocol = viewController
    }
    
    func detachView() {
        createDiaryViewProtocol = nil
    }
    
    func addDiaryToServer(diary: Diary, callback: @escaping (_ diarys: DiaryDB?, _ error: Error?) -> Void) {
        createDiaryViewProtocol?.startLoading()
        diaryService.addDiaryToServer(diary: diary) { (error) in
            self.createDiaryViewProtocol?.finishLoading()
            if let error = error {
                callback(nil, error)
            } else {
                let tuple = CoreDataManager.shared.createDiary(diary: diary)
                if let saveErr = tuple.1 {
                    callback(nil, saveErr)
                } else {
                    callback(tuple.0, nil)
                }
            }
        }
    }
    
    func updateDiaryToServer(diaryDB: DiaryDB, callback: @escaping (Error?) -> Void) {
        createDiaryViewProtocol?.startLoading()
        diaryService.updateDiaryToServer(diaryDB: diaryDB) { (error) in
            self.createDiaryViewProtocol?.finishLoading()
            if let error = error {
                callback(error)
            } else {
                let error = CoreDataManager.shared.updateDiary(diaryDB: diaryDB)
                if let updateErr = error {
                    callback(updateErr)
                } else {
                    callback(nil)
                }
            }
        }
    }
    
    
}
