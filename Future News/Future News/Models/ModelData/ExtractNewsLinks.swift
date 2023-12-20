
import Foundation

struct ExtractNewsLinks: Codable {
    let status: String
    let newsLinks: [String]

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case newsLinks = "news_links"
    }
}
