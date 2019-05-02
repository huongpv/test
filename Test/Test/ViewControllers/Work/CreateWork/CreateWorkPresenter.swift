//
//  CreateWorkPresenter.swift
//  Test
//
//  Created by Macbook on 3/2/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

protocol CreateWorkProtocol: BaseProtocol {

}

class CreateWorkPresenter {
    private let workService: DiaryService
    weak private var createWorkViewProtocol: CreateWorkProtocol?
    
    init(workService: DiaryService) {
        self.workService = workService
    }
    
    func attachViewController(_ viewController: CreateWorkProtocol){
        createWorkViewProtocol = viewController
    }
    
    func detachView() {
        createWorkViewProtocol = nil
    }
    
    func addworkToServer(title: String, content: String, coverUrl: String, publishedAt: Date, mood: String , callback: @escaping (_ works: WorkDB?, _ error: Error?) -> Void) {
        guard let uid = SharedData.accessToken else { return }
        let viewContext = CoreDataManager.shared.persistenContainer.viewContext
        let workDB = WorkDB(context: viewContext)
        workDB.title = title
        workDB.content = content
        workDB.coverUrl = coverUrl
        workDB.publishedAt = publishedAt
        workDB.mood = mood
        
        createWorkViewProtocol?.startLoading()
        workService.addWorkToServer(uid: uid, work: workDB) { (documentId, error) in
            self.createWorkViewProtocol?.finishLoading()
            if let error = error {
                callback(nil, error)
            } else {
                // add documentId to object
                workDB.id = documentId
                CoreDataManager.shared.add(object: workDB)
                callback(workDB, nil)
            }
        }
    }
    
    func updateworkToServer(workDB: WorkDB, callback: @escaping (Error?) -> Void) {
        guard let uid = SharedData.accessToken else { return }
        createWorkViewProtocol?.startLoading()
        workService.updateWorkToServer(uid: uid, workDB: workDB) { (error) in
            self.createWorkViewProtocol?.finishLoading()
            if let error = error {
                callback(error)
            } else {
                let error = CoreDataManager.shared.update(object: workDB)
                if let updateErr = error {
                    callback(updateErr)
                } else {
                    callback(nil)
                }
            }
        }
    }
    
    
}
