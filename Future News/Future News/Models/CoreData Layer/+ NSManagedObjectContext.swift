//
//  + NSManagedObjectContext.swift
//  Future News
//
//  Created by Danya Denisiuk on 02.02.2024.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func saveContext() {
        if self.hasChanges {
            do {
                try self.save()
            } catch let nserror as NSError {
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
