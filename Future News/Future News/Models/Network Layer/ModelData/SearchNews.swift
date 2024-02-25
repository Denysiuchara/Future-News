
import Foundation


// MARK: - SearchNews
struct SearchNews: Codable {
    let offset: Int
    let number: Int
    let available: Int
    let news: [News]
    
    enum CodingKeys: String, CodingKey {
        case offset = "offset"
        case number = "number"
        case available = "available"
        case news = "news"
    }
}

// MARK: - News
struct News: Codable, Identifiable {
    let id: Int
    let title: String
    let text: String
    let url: String?
    let image: String?
    let publishDate: String
    let author: String?
    let language: String
    let sourceCountry: String
    
    let isSaveNews: Bool = false
    
    var imageURL: URL {
        guard let imageBundlePath = Bundle.main.path(forResource: "news-placeholder", ofType: "jpg") else {
            assert(false , "Cannot find news-placeholder")
        }
        
        let imageURLInBundle = URL(string: imageBundlePath)
        
        if let imageWebPath = image, let imageURLInWeb = URL(string: imageWebPath) {
            return imageURLInWeb
        } else {
            return imageURLInBundle!
        }
    }
    
    
    var sourceURL: URL {
        let endpoint = "https://sites.google.com/d/1j7jgRhJYpc0R6AfvUpDjE2AY1Am4hAg0/p/1nw79WLYVdXM6v1LO4zjT_S0d-jjPl7zZ/edit"
        
        if let url = url, let sourceURL = URL(string: url) {
            return sourceURL
        } else {
            return URL(string: endpoint)!
        }
    }
    
    var convertedPublishDate: Date {
        self.publishDate.convertToDate()
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case text = "text"
        case url = "url"
        case image = "image"
        case publishDate = "publish_date"
        case author = "author"
        case language = "language"
        case sourceCountry = "source_country"
    }
}
