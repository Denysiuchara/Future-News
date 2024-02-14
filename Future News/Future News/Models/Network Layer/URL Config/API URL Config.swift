
import Foundation

final class APIURLConfig {
    private(set) var apiKey = "8c25c03b336b45068fe0a37960b99b43"
    private let startpoint = "https://api.worldnewsapi.com"
    
    static var shared = APIURLConfig()
    
    private init() {}
    
    func createURL(path: APIPath, parameters: [APIParameter: String] = [:]) throws -> URL {

        guard var components = URLComponents(string: startpoint) else { throw APIConfiqError.invalidComponents }
                  components.path = path.rawValue
                  components.queryItems = createQueryItems(parameters)
        
        guard let url = components.url else { throw APIConfiqError.invalidURL }
        
        print("APIURLConfig: changeAPIKey(): Сгенерирован url: \(url)")
        
        return url
    }
    
    
    private func createQueryItems(_ parameters: [APIParameter: String]) -> [URLQueryItem] {
        print("APIURLConfig: createQueryItems(): Вызов метода")
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api-key", value: apiKey),
            URLQueryItem(name: "number", value: "100"),
            URLQueryItem(name: "language", value: Locale.current.language.languageCode?.identifier)
//            URLQueryItem(name: "earliest-publish-date", value: Date().convertToString())
        ]
        
        for (name, value) in parameters {
            queryItems.append(URLQueryItem(name: name.rawValue, value: value))
        }
        
        print("APIURLConfig: changeAPIKey(): Сгенерировал элементы запроса: \(queryItems)")
        
        return queryItems
    }
}
