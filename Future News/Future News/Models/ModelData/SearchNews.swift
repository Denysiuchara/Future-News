
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
    var id: Int
    var title: String
    var text: String
    var url: String
    var image: String
    var publishDate: String
    var language: String
    var sourceCountry: String
    var sentiment: Double
    var author: String?
    
    var isSaveNews: Bool = false
    
    var imageURL: URL {
        let imagePath = Bundle.main.path(forResource: "news_blank_image", ofType: "jpg")
        
        let imageURLInBundle = URL(string: imagePath!)
        let imageURLInWeb = URL(string: image)
        
        return imageURLInWeb ?? imageURLInBundle!
    }
    
    var sourceURL: URL {
        let endpoint = "https://sites.google.com/d/1j7jgRhJYpc0R6AfvUpDjE2AY1Am4hAg0/p/1nw79WLYVdXM6v1LO4zjT_S0d-jjPl7zZ/edit"
        
        return URL(string: url) ?? URL(string: endpoint)!
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
        case sentiment = "sentiment"
    }
}

extension News {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.text = try container.decode(String.self, forKey: .text)
        self.url = try container.decode(String.self, forKey: .url)
        self.image = try container.decode(String.self, forKey: .image)
        self.publishDate = try container.decode(String.self, forKey: .publishDate)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.language = try container.decode(String.self, forKey: .language)
        self.sourceCountry = try container.decode(String.self, forKey: .sourceCountry)
        self.sentiment = try container.decode(Double.self, forKey: .sentiment)
    }
}

extension News {
    init() {
        self.id = 0
        self.title = ""
        self.text = ""
        self.url = ""
        self.image = ""
        self.publishDate = ""
        self.language = ""
        self.sourceCountry = ""
        self.sentiment = 0.0
        self.author = nil
    }
}
