
import Foundation

class APIURLConfig {
    private(set) var apiKey = "f5aff4e7bf0b404aa412f96735a4c84c"
    private let startpoint = "https://api.worldnewsapi.com"
    
    static var shared = APIURLConfig()
    
    private init() {}
    
    /// The key must be 32 characters long.
    ///
    /// New key generate: [Console](https://worldnewsapi.com/console/#Profile)
    func changeAPIKey(_ newKey: String) throws {
        guard newKey.count == 32 else { throw APIConfiqError.invalidKey }
        self.apiKey = newKey
    }
    
    func createURL(path: APIPath, parameters: [APIParameter: String] = [:]) throws -> URL {
        guard var components = URLComponents(string: startpoint) else { throw APIConfiqError.invalidComponents }
                  components.path = path.rawValue
                  components.queryItems = createQueryItems(parameters)
        
        guard let url = components.url else { throw APIConfiqError.invalidURL }
        
        return url
    }
    
    
    private func createQueryItems(_ parameters: [APIParameter: String]) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = [URLQueryItem(name: "api-key", value: apiKey)]
        
        for (name, value) in parameters {
            queryItems.append(URLQueryItem(name: name.rawValue, value: value))
        }
        
        return queryItems
    }
}
