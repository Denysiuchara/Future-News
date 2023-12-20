
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
    let url: String
    let image: String
    let publishDate: String
    let language: String
    let sourceCountry: String
    let sentiment: Double
    let author: String?
    
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
        case sentiment = "sentiment"
    }
}
