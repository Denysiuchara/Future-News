//
//  CoreDataService.swift
//  Future News
//
//  Created by Danya Denisiuk on 02.02.2024.
//

import Foundation
import CoreData
import Combine

final class CoreDataService {
    static var shared = CoreDataService()
    
    static var preview: CoreDataService = {
        let result = CoreDataService(inMemory: true)
        let viewContext = result.previewContainer?.viewContext
        for i in 0..<10 {
            let entity = NewsEntity(context: viewContext ?? result.context)
            entity.author = "Some Author"
            entity.id = i.to()
            entity.imageURL = entity.imageURL_
            entity.isSaveNews = false
            entity.language = "en"
            entity.publishDate = "2020:20:20 20:20"
            entity.sentiment = 0.0
            entity.sourceCountry = ""
            entity.sourceURL = entity.sourceURL_
            entity.text = textForPreview
            entity.title = "Title"
        }
        
        do {
            try viewContext?.save()
        } catch {
            print(error.localizedDescription)
        }
        return result
    }()
    
    let previewContainer: NSPersistentContainer?
    
    private init (inMemory: Bool = false) {
        if inMemory {
            self.previewContainer = NSPersistentContainer(name: "DataModel")
            previewContainer?.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
            previewContainer?.viewContext.automaticallyMergesChangesFromParent = true
            previewContainer?.loadPersistentStores { (storeDescription, error) in
                
                if let nserror = error as NSError? {
                    fatalError("\(nserror.userInfo)")
                }
            }
        } else {
            previewContainer = nil
        }
    }
    
    var isCoreDataStackFilled = CurrentValueSubject<Bool, Never>(false)
    
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
    
    func insertData(_ newsList: [News]) {
        persistentContainer.performBackgroundTask { context in
            newsList.forEach { news in
                _ = NewsEntity.insert(news: news, to: context)
            }
            context.saveContext()
        }
    }
    
    func hasEntities() {
        let fetchRequest = NewsEntity.fetchRequest()
        
        do {
            let count = try CoreDataService.shared.context.count(for: fetchRequest)
            print("\(#function): \(count)")
            isCoreDataStackFilled.send(true)
        } catch {
            print("Error counting entities: \(error)")
            isCoreDataStackFilled.send(false)
        }
    }
}




var textForPreview = 
"""
Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,
Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,
"""
