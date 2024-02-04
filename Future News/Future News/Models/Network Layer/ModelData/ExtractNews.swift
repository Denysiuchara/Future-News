
import Foundation

struct ExtractNews: Codable {
    let title: String
    let text: String
    let url: String
    let image: String
    let publishDate: String
    let author: String
    let language: String
    let sentiment: Double
    let entities: [Entity]

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case text = "text"
        case url = "url"
        case image = "image"
        case publishDate = "publish_date"
        case author = "author"
        case language = "language"
        case sentiment = "sentiment"
        case entities = "entities"
    }
}

// MARK: - Entity
struct Entity: Codable {
    let type: String
    let name: String
    let latitude: Double
    let longitude: Double
    let locationType: String

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case name = "name"
        case latitude = "latitude"
        case longitude = "longitude"
        case locationType = "location_type"
    }
}
