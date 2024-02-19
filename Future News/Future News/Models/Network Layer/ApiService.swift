import Combine
import Foundation

final class ApiService {
    
    typealias Parameters = [APIURLConfig.APIParameter : String]
    
    private static var cancellables = Set<AnyCancellable>()
    
    static func getData<T: Codable>(path: APIURLConfig.APIPath,
                                    parameters: Parameters = [:],
                                    isCustomDate: Bool = false,
                                    _ onResponse: @escaping (Result<T, Error>) -> Void) {
        
        
        guard let url = try? APIURLConfig.shared.createURL(path: path,
                                                           parameters: parameters,
                                                           isCustomDate: isCustomDate)
        else {
            onResponse(.failure(ApiServiceError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                onResponse(.failure(ApiServiceError.invalidURL))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.isSuccess else {
                onResponse(.failure(ApiServiceError.returnError))
                return
            }
            
            guard let data = data else {
                onResponse(.failure(ApiServiceError.invalidData))
                return
            }
            
            onResponse(ApiService.decode(data: data))
            
        }.resume()
    }
    
    enum ApiServiceError: Error {
        case invalidURL
        case returnError
        case invalidDecoding
        case feedRSSPick
        case invalidData
    }
}
