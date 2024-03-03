
import Foundation

class ApiService {
    
    typealias Parameters = [APIURLConfig.APIParameter : String]

    static func getData<T: Codable>(path: APIURLConfig.APIPath,
                                     parameters: Parameters = [:],
                                     _ onResponse: @escaping (Result<T, Error>) -> Void) {

        guard let url = try? APIURLConfig.shared.createURL(path: path, parameters: parameters) else {
            onResponse(.failure(ApiServiceError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
            request.timeoutInterval = 180
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                onResponse(.failure(ApiServiceError.invalidURL))
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                print("Server available\n")
            } else if response.statusCode == 402 {
                print("The quota has been exhausted\n")
                return
            } else if response.statusCode == 429 {
                print("Quota of requests per time period exceeded")
                print("Make sure there was no more than 1request/s or 60requests/min")
                return
            }
            
            guard let data = data else {
                onResponse(.failure(ApiServiceError.invalidData))
                return
            }
            
            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                onResponse(.success(decodeData))
                print("Do-catch block")
            } catch {
                print(error.localizedDescription)
                onResponse(.failure(error))
            }
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