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
    //data for preview
    static var preview: CoreDataProvider = {
        let provider = CoreDataProvider(inMemory: true)
        let context = provider.context
        
        //dummy data
        let entertaiment = Budget(context: context)
        entertaiment.title = "Movie"
        entertaiment.limit = 100
        entertaiment.dateCreated = Date()
        
        let groceries = Budget(context: context)
        groceries.title = "Vegs"
        groceries.limit = 150
        groceries.dateCreated = Date()
        
        let milk = Expense(context: context)
        milk.title = "Milk"
        milk.amount = 10
        milk.dateCreated = Date()
        
        groceries.addToExpense(milk)
        
        let cookies = Expense(context: context)
        cookies.title = "Cookies"
        cookies.amount = 5.45
        cookies.dateCreated = Date()
        
        groceries.addToExpense(cookies)
        
        
        do{
            try context.save()
        }catch{
            print(error)
        }
        return provider
    }()
    
    
    
    
    
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
