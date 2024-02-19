
import Foundation

final class APIURLConfig {
    private(set) var apiKey = "8c25c03b336b45068fe0a37960b99b43"
    private let startpoint = "https://api.worldnewsapi.com"
    
    static var shared = APIURLConfig()
    
    private init() {}
    
    func createURL(path: APIPath, parameters: [APIParameter: String] = [:], isCustomDate: Bool = false) throws -> URL {

        guard var components = URLComponents(string: startpoint) else { throw APIConfiqError.invalidComponents }
                  components.path = path.rawValue
                  components.queryItems = createQueryItems(parameters, isCustomDate: isCustomDate)
        
        guard let url = components.url else { throw APIConfiqError.invalidURL }
        
        print("APIURLConfig: changeAPIKey(): Сгенерирован url: \(url)")
        
        return url
    }
    
    
    private func createQueryItems(_ parameters: [APIParameter: String], isCustomDate: Bool = false) -> [URLQueryItem] {
        print("APIURLConfig: createQueryItems(): Вызов метода")
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api-key", value: apiKey),
            URLQueryItem(name: "number", value: "100"),
            URLQueryItem(name: "language", value: Locale.current.language.languageCode?.identifier),
        ]
        
        if !isCustomDate {
            queryItems
                .append(
                    URLQueryItem(
                        name: "earliest-publish-date",
                        value: Date()
                                .convertToString()
                                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    )
                )
        }
        
        for (name, value) in parameters {
            let encodeValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            queryItems.append(URLQueryItem(name: name.rawValue, value: encodeValue))
        }
        
        print("APIURLConfig: changeAPIKey(): Сгенерировал элементы запроса: \(queryItems)")
        
        return queryItems
    }
}


