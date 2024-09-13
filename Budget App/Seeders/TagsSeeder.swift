//
//  TagsSeeder.swift
//  Budget App
//
//  Created by Anup Saud on 2024-09-12.
//

import Foundation
import CoreData

class TagsSeeder{
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func seed(commonTags: [String]) throws {
        for commonTag in commonTags {
            let tag = Tag(context: context)
            tag.name = commonTag
            try context.save()

        }
    }
}
