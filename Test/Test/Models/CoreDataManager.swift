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
    let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    
    let persistenContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func add<T: NSManagedObject>(objects: [T]) {
        privateContext.parent = CoreDataManager.shared.persistenContainer.viewContext

        do {
            try privateContext.save()
            try privateContext.parent?.save()
        } catch let err {
            print("\(err.localizedDescription)")
        }
    }
    
    func getDataFromDB<T: NSManagedObject>(type: T.Type) -> [T] {
        let context = persistenContainer.viewContext
        
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        
        do {
            let objects = try context.fetch(fetchRequest)
            
            return objects
        } catch let fetchErr {
            print("Failed to fetch companies", fetchErr)
            return []
        }
    }
    
    func add<T: NSManagedObject>(object: T) {
        do {
            try persistenContainer.viewContext.save()
        } catch let saveErr {
            print("Failed to save company: ", saveErr)
        }
    }
    
    func update<T: NSManagedObject>(object: T) -> (Error?) {
        do {
            try persistenContainer.viewContext.save()
            return (nil)
        } catch let saveErr {
            print("Failed to update diary: ", saveErr)
            return (saveErr)
        }
    }
    
    func delete<T: NSManagedObject>(type: T.Type) {
        let context = CoreDataManager.shared.persistenContainer.viewContext
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: T.fetchRequest())
        
        do {
            try context.execute(batchDeleteRequest)
        } catch let delErr {
            print("Error: \(delErr.localizedDescription)")
        }
    }
    
}
