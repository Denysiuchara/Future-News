//
//  + NewsEntity.swift
//  Future News
//
//  Created by Danya Denisiuk on 02.02.2024.
//

import Foundation
import CoreData

extension NewsEntity {
    
    static func fetch() -> NSFetchRequest<NewsEntity> {
        let request = NSFetchRequest<NewsEntity>(entityName: "NewsEntity")
            request.sortDescriptors = [NSSortDescriptor(keyPath: \NewsEntity.publishDate, ascending: true)]
        return request
    }
    
    
    var author_: String {
        get { author ?? "" }
        set { author = newValue }
    }
    
    var id_: Int {
        get { Int(id) }
        set { id = Int32(newValue) }
    }
    
    var imageURL_: URL {
        get {
            if let imagePath = Bundle.main.path(forResource: "news_blank_image", ofType: "jpg") {
                return imageURL ?? URL(fileURLWithPath: imagePath)
            } else {
                // Путь к заглушке не найден - вернем imageURL или пустой URL
                return imageURL ?? URL(fileURLWithPath: "")
            }
        }
        set { imageURL = newValue }
    }
    
    var isSaveNews_: Bool {
        get { isSaveNews }
        set { isSaveNews = newValue }
    }
    
    var language_: String {
        get { language ?? "" }
        set { language = newValue }
    }
    
    var publishDate_: Date {
        get { publishDate ?? Date() }
        set { publishDate = newValue }
    }
    
    var sentiment_: Double {
        get { sentiment }
        set { sentiment = newValue }
    }
    
    var sourceCountry_: String {
        get { sourceCountry ?? "" }
        set { sourceCountry = newValue }
    }
    
    var sourceURL_: URL {
        get {
            let defaultPath = "https://sites.google.com/d/1j7jgRhJYpc0R6AfvUpDjE2AY1Am4hAg0/p/1nw79WLYVdXM6v1LO4zjT_S0d-jjPl7zZ/edit"
            return sourceURL ?? URL(string: defaultPath) ?? URL(fileURLWithPath: "")
        }
        set { sourceURL = newValue }
    }
    
    var text_: String {
        get { text ?? "" }
        set { text = newValue }
    }
    
    var title_: String {
        get { title ?? "" }
        set { title = newValue }
    }
    
    static func insert(news: News, to context: NSManagedObjectContext) -> NewsEntity {
        
        let localNews = NewsEntity(entity: NewsEntity.entity(), insertInto: context)
            localNews.id = news.id.to()
            localNews.author = news.author
            localNews.imageURL = news.imageURL
            localNews.isSaveNews = news.isSaveNews
            localNews.language = news.language
            localNews.publishDate = news.convertedPublishDate
            localNews.sentiment = news.sentiment
            localNews.sourceCountry = news.sourceCountry
            localNews.sourceURL = news.sourceURL
            localNews.text = news.text
            localNews.title = news.title
        
        return localNews
    }
    
    func toggle() {
        if self.isSaveNews == true {
            self.setValue(false, forKey: "isSaveNews")
        } else {
            self.setValue(true, forKey: "isSaveNews")
        }
        
        CoreDataService.shared.context.saveContext()
    }
}

