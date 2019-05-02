//
//  WorkPresenter.swift
//  Test
//
//  Created by huongpv on 5/2/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

protocol WorkProtocol: BaseProtocol {
    func setWorks(_ diarys: [WorkDB])
}

class WorkPresenter {
    private let service: DiaryService
    weak private var viewProtocol: WorkProtocol?
    
    init(service: DiaryService) {
        self.service = service
    }
    
    func attachViewController(_ viewController: WorkProtocol){
        viewProtocol = viewController
        // Get diaries
        getDiarys()
    }
    
    func detachView() {
        viewProtocol = nil
    }
    
    private func getDiarys() {
        guard let uid = SharedData.accessToken else { return }
        if let _ = SharedData.isSyncData {
            getWorksFromDB()
        } else {
            getWorksFromServer(uid: uid)
        }
    }
    
    private func getWorksFromDB() {
        viewProtocol?.startLoading()
        let sort = NSSortDescriptor(key: "publishedAt", ascending: false)
        let limit = 10
        let works = CoreDataManager.shared.getDataBySort(type: WorkDB.self, sort: sort, limit: limit)
        viewProtocol?.setWorks(works)
        viewProtocol?.finishLoading()
        
    }
    
    // when login success then save diaries to database
    private func getWorksFromServer(uid: String) {
        viewProtocol?.startLoading()
        service.getWorksFromServer(uid: uid) { (works, error) in
            self.viewProtocol?.finishLoading()
            if let _ = error {
                print("getDiariesFromServer Fail")
            } else {
                guard let worksJSON = works else { return }
                // save diaries to database
                self.saveWorkToDB(objects: worksJSON)
                // set isSyncData
                SharedData.isSyncData = true
                // get diarys
                self.getDiarys()
            }
        }
    }
    
    private func saveWorkToDB(objects: [Work]) {
        var works = [WorkDB]()
        for item in objects {
            let work = WorkDB(context: CoreDataManager.shared.privateContext)
            work.id = item.id
            work.title = item.title
            work.content = item.content
            work.coverUrl = item.coverUrl
            work.mood = item.mood
            work.publishedAt = item.publishedAt?.dateBy(format: DateFormat.dateTimeWithSlash)
            works.append(work)
        }
        
        CoreDataManager.shared.add(objects: works)
    }
}
