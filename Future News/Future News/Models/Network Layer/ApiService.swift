import Combine
import Foundation

final class ApiService {
    
    static var statusCodeSubject = CurrentValueSubject<Int, Never>(200)
    
    typealias Parameters = [APIURLConfig.APIParameter : String]

    static func getData<T: Codable>(path: APIURLConfig.APIPath,
                                     parameters: Parameters = [:],
                                     _ onResponse: @escaping (Result<T, Error>) -> Void) {

        guard let url = try? APIURLConfig.shared.createURL(path: path, parameters: parameters) else {
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
            
            statusCodeSubject.send(httpResponse.statusCode)
            
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
