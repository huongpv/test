//
//  DiaryPresenter.swift
//  Test
//
//  Created by huongpv on 2/28/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

protocol DiaryProtocol: BaseProtocol {
    func setDiarys(_ diarys: [DiaryDB])
}

class DiaryPresenter {
    private let diaryService: DiaryService
    weak private var diaryViewProtocol: DiaryProtocol?
    
    init(diaryService: DiaryService) {
        self.diaryService = diaryService
    }
    
    func attachViewController(_ viewController: DiaryProtocol){
        diaryViewProtocol = viewController
        // Register remote notifications
        NotificationService.instance.registerPushNotification()
        // Get diaries
        getDiarys()
    }
    
    func detachView() {
        diaryViewProtocol = nil
    }
    
    private func getDiarys() {
        guard let uid = SharedData.accessToken else { return }
        if let _ = SharedData.isSyncData {
            getDiariesFromDB()
        } else {
            getDiariesFromServer(uid: uid)
        }
    }
    
    private func getDiariesFromDB() {
        diaryViewProtocol?.startLoading()
        let sort = NSSortDescriptor(key: "publishedAt", ascending: false)
        let limit = 10
        let diarys = CoreDataManager.shared.getDataBySort(type: DiaryDB.self, sort: sort, limit: limit)
        diaryViewProtocol?.setDiarys(diarys)
        diaryViewProtocol?.finishLoading()

    }
    
    // when login success then save diaries to database
    private func getDiariesFromServer(uid: String) {
        diaryViewProtocol?.startLoading()
        diaryService.getDiariesFromServer(uid: uid) { (diaries, error) in
            self.diaryViewProtocol?.finishLoading()
            if let _ = error {
                print("getDiariesFromServer Fail")
            } else {
                guard let diariesJSON = diaries else { return }
                // save diaries to database
                self.saveDiariesToDB(objects: diariesJSON)
                // set isSyncData
                SharedData.isSyncData = true
                // get diarys
                self.getDiarys()
            }
        }
    }
    
    private func saveDiariesToDB(objects: [Diary]) {
        var diaries = [DiaryDB]()
        for item in objects {
            let diary = DiaryDB(context: CoreDataManager.shared.privateContext)
            diary.id = item.id
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
