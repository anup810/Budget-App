//
//  CoreDataProvider.swift
//  Budget App
//
//  Created by Anup Saud on 2024-09-11.
//

import Foundation
import CoreData

class CoreDataProvider{
    let persistentContainer : NSPersistentContainer
    
    var context: NSManagedObjectContext{
        persistentContainer.viewContext
    }
    
    init(inMemory:Bool = false){
        persistentContainer = NSPersistentContainer(name: "BudgetAppModel")
        
        if inMemory{
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data store failed to initialize \(error)")
            }
        }
    }
}
