//
//  Budget+Extension.swift
//  Budget App
//
//  Created by Anup Saud on 2024-09-11.
//

import Foundation
import CoreData

extension Budget{
    static func exits(context : NSManagedObjectContext, title: String) -> Bool{
        let request = Budget.fetchRequest()
        request.predicate = NSPredicate(format: "title ==%@", title)
        do{
            let results = try context.fetch(request)
            return !results.isEmpty
        }catch{
            return false
        }
    }
}
