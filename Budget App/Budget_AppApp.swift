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
    init(){
        provider = CoreDataProvider()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, provider.context)
        }
    }
}
