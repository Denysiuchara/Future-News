//
//  + NewsEntity.swift
//  Future News
//
//  Created by Danya Denisiuk on 02.02.2024.
//

import Foundation

extension NewsEntity {
    
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
            let imagePath = Bundle.main.path(forResource: "news_blank_image", ofType: "jpg")!
            
            return imageURL ?? URL(filePath: imagePath)
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
    
    var publishDate_: String {
        get { publishDate ?? "" }
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
            let str = "https://sites.google.com/d/1j7jgRhJYpc0R6AfvUpDjE2AY1Am4hAg0/p/1nw79WLYVdXM6v1LO4zjT_S0d-jjPl7zZ/edit"
            
            return sourceURL ?? URL(string: str)!
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
}
