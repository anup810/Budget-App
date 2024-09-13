//
//  Budget_AppApp.swift
//  Budget App
//
//  Created by Anup Saud on 2024-08-25.
//

import SwiftUI

@main
struct Budget_AppApp: App {
    let provider: CoreDataProvider
    let tagSeeder: TagsSeeder
    init(){
        provider = CoreDataProvider()
        tagSeeder = TagsSeeder(context: provider.context)
    }
    var body: some Scene {
        WindowGroup {
            BudgetListScreen()
                .onAppear(perform: {
                    let hasSeededData = UserDefaults.standard.bool(forKey: "hasSeedData")
                    if !hasSeededData{
                        let commonTags = ["Food","Dining","Travel","Entertainment","Shopping","Transportation","Utilities","Groceries","Health","Education"]
                        do{
                            try tagSeeder.seed(commonTags: commonTags)
                            UserDefaults.standard.setValue(true, forKey: "hasSeedData")
                        }catch{
                            print(error)
                        }
                        
                    }
                    
                })
                .environment(\.managedObjectContext, provider.context)
        }
    }
}
