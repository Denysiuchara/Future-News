
import Foundation

extension APIURLConfig {
    enum APIParameter: String, Hashable {
        
        // MARK: - SEARCH-NEWS PARAMETERS
        
        /// The text to match in the news content.
        case text = "text"
        
        /// A comma-separated list of [ISO 3166 country codes](https://worldnewsapi.com/docs/#Country-Codes) from which the news should originate.
        case sourceCountries = "source-countries"
        
        /// The [ISO 6391 language code](https://worldnewsapi.com/docs/#Language-Codes) of the news.
        case language = "language"
        
        /// The minimal sentiment of the news in range [-1,1].
        ///
        /// Type: number
        case minSentiment = "min-sentiment"
        
        /// The maximal sentiment of the news in range [-1,1].
        ///
        /// Type: number
        case maxSentiment = "max-sentiment"
        
        /// The news must have been published after this date.
        ///
        /// Example Format: 2022-04-22 16:12:35
        case earliestPublishDate = "earliest-publish-date"
        
        /// The news must have been published before this date.
        ///
        /// Example Format:2022-04-22 16:12:35
        case latestPublishDate = "latest-publish-date"
        
        /// A comma-separated list of news sources from which the news should originate.
        case newsSources = "news-sources"
        
        /// A comma-separated list of author names. Only news from any of the given authors will be returned.
        case authors = "authors"
        
        /// Filter news by entities. [Sematic type](https://worldnewsapi.com/docs/#Semantic-Types)
        case entities = "entities"
        
        /// Filter news by radius around a certain location. Format is "latitude,longitude,radius in kilometers"
        case locationFilter = "location-filter"
        
        /// The sorting criteria (publish-time or sentiment).
        case sort = "sort"
        
        /// Whether to sort ascending or descending (ASC or DESC).
        case sortDirection = "sort-direction"
        
        /// The number of news to skip in range [0,10000]
        ///
        /// Type: number
        case offset = "offset"
        
        /// The number of news to return in range [1,100]
        ///
        /// Type: number
        case number = "number "
        
        // MARK: - EXTRACT-NEWS PARAMETERS
        case url = "url"
        
        /// Whether to analyze the news.
        ///
        /// Type: bool
        case analyze = "analyze"
        
        // MARK: - EXTRACT-NEWS-LINKS PARAMETERS
        case prefix = "prefix"
        
        /// Whether to include links to news on sub-domains.
        ///
        /// Type: bool
        case subDomain = "sub-domain"
        
        // MARK: - RSS FEED PARAMETERS
        /// Whether extract news and add information such as description, publish date, and image to each item.
        ///
        /// Type: bool
        case extractNews = "extract-news"
        
        // MARK: - GEO COORDINATES PARAMETERS
        /// The address or name of the location.
        ///
        /// Example: Tokyo, Japan
        case location = "location"
    }
}
