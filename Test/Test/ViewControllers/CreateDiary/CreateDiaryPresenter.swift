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
    
    func addDiaryToServer(title: String, content: String, coverUrl: String, publishedAt: Date, mood: String , callback: @escaping (_ diarys: DiaryDB?, _ error: Error?) -> Void) {
        guard let uid = SharedData.accessToken else { return }
        let viewContext = CoreDataManager.shared.persistenContainer.viewContext
        let diaryDB = DiaryDB(context: viewContext)
        diaryDB.title = title
        diaryDB.content = content
        diaryDB.coverUrl = coverUrl
        diaryDB.publishedAt = publishedAt
        diaryDB.mood = mood
        
        createDiaryViewProtocol?.startLoading()
        diaryService.addDiaryToServer(uid: uid, diary: diaryDB) { (documentId, error) in
            self.createDiaryViewProtocol?.finishLoading()
            if let error = error {
                callback(nil, error)
            } else {
                // add documentId to object
                diaryDB.id = documentId
                CoreDataManager.shared.add(object: diaryDB)
                callback(diaryDB, nil)
            }
        }
    }
    
    func updateDiaryToServer(diaryDB: DiaryDB, callback: @escaping (Error?) -> Void) {
        guard let uid = SharedData.accessToken else { return }
        createDiaryViewProtocol?.startLoading()
        diaryService.updateDiaryToServer(uid: uid, diaryDB: diaryDB) { (error) in
            self.createDiaryViewProtocol?.finishLoading()
            if let error = error {
                callback(error)
            } else {
                let error = CoreDataManager.shared.update(object: diaryDB)
                if let updateErr = error {
                    callback(updateErr)
                } else {
                    callback(nil)
                }
            }
        }
    }
    
    
}
