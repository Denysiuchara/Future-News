//
//  CoreDataService.swift
//  Future News
//
//  Created by Danya Denisiuk on 02.02.2024.
//

import Foundation
import CoreData

class CoreDataService {
    static var shared = CoreDataService()
    
    private init () {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        
        container.loadPersistentStores { storeDescription, error in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let nserror = error as? NSError {
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
        return container
    }()
    
    
    lazy var context: NSManagedObjectContext = { persistentContainer.viewContext }()
    
    lazy var entity: NSEntityDescription = { NSEntityDescription.entity(forEntityName: "NewsEntity", in: context) }()!
    
    func setData(_ news: News) {
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(news.author, forKey: "author")
            managedObject.setValue(news.id, forKey: "id")
            managedObject.setValue(news.imageURL, forKey: "imageURL")
            managedObject.setValue(news.isSaveNews, forKey: "isSaveNews")
            managedObject.setValue(news.language, forKey: "language")
            managedObject.setValue(news.publishDate, forKey: "publishDate")
            managedObject.setValue(news.sentiment, forKey: "sentiment")
            managedObject.setValue(news.sourceCountry, forKey: "sourceCountry")
            managedObject.setValue(news.sourceURL, forKey: "sourceURL")
            managedObject.setValue(news.text, forKey: "text")
            managedObject.setValue(news.title, forKey: "title")
        
        context.saveContext()
    }
}
