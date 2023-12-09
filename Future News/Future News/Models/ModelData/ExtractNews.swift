
import Foundation

struct ExtractNews: Codable {
    let title: String
    let text: String
    let url: String
    let image: String
    let publishDate: String
    let author: String
    let language: String
//    let sourceCountry: String?
//    let sentiment: Double?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case text = "text"
        case url = "url"
        case image = "image"
        case publishDate = "publish_date"
        case author = "author"
        case language = "language"
//        case sourceCountry = "source_country"
//        case sentiment = "sentiment"
    }
}
