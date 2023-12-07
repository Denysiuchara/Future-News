
import Foundation

extension APIURLConfig {
    enum APIPath: String, Hashable {
        case searchNews = "/search-news"
        case extractNews = "/extract-news"
        case extractNewsLinks = "/extract-news-links"
        case feedRSS = "/feed.rss"
        case coordinates = "/geo-coordinates"
    }
}
