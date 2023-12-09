
import Foundation

struct ExtractNewsLinks: Codable {
    let newsLinks: [String]

    enum CodingKeys: String, CodingKey {
        case newsLinks = "news_links"
    }
}
