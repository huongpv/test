//
//  CoreDataManager.swift
//  Test
//
//  Created by Macbook on 3/2/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistenContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func saveDiaries(diaries: [Diary]) {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = CoreDataManager.shared.persistenContainer.viewContext
        
        diaries.forEach({ (jsonDiary) in
            let newDiary = DiaryDB(context: privateContext)
            
            newDiary.title = jsonDiary.title
            newDiary.content = jsonDiary.content
            newDiary.coverUrl = jsonDiary.coverUrl
            newDiary.mood = jsonDiary.mood
            newDiary.publishedAt = jsonDiary.publishedAt
        })
        
        do {
            try privateContext.save()
            try privateContext.parent?.save()
        } catch let err {
            print("\(err.localizedDescription)")
        }
    }
    
    // Diary
    func fetchDiarys() -> [DiaryDB] {
        let context = persistenContainer.viewContext
        
        let fetchRequest = NSFetchRequest<DiaryDB>(entityName: "DiaryDB")
        
        do {
            let diarys = try context.fetch(fetchRequest)
            
            return diarys
        } catch let fetchErr {
            print("Failed to fetch companies", fetchErr)
            return []
        }
    }
    
    func createDiary(diary: Diary) -> (DiaryDB?, Error?) {
        let context = CoreDataManager.shared.persistenContainer.viewContext
        let diaryDB = NSEntityDescription.insertNewObject(forEntityName: "DiaryDB", into: context) as! DiaryDB
        diaryDB.title = diary.title
        diaryDB.content = diary.content
        diaryDB.coverUrl = diary.coverUrl
        diaryDB.publishedAt = diary.publishedAt
        diaryDB.mood = diary.mood
        
        // perform the save
        do {
            // success
            try context.save()
            return (diaryDB, nil)
        } catch let saveErr {
            print("Failed to save company: ", saveErr)
            return (nil, saveErr)
        }
    }
    
    func updateDiary(diaryDB: DiaryDB) -> (Error?) {
        let context = CoreDataManager.shared.persistenContainer.viewContext
        
        // perform the save
        do {
            // success
            try context.save()
            return (nil)
        } catch let saveErr {
            print("Failed to save company: ", saveErr)
            return (saveErr)
        }
    }
    
}
