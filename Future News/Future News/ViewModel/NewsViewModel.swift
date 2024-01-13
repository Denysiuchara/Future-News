
import Combine
import Foundation

class NewsViewModel: ObservableObject {
    @Published var searchNews: SearchNews?
    @Published var extractNews: ExtractNews?
    @Published var extractNewsLinks: ExtractNewsLinks?
    @Published var geoCoordinates: GeoCoordinates?
    
    @Published var isFailedStatusCode = false
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        ApiService.statusCodeSubject
            .sink { [weak self] statusCode in
                guard let self = self else { return }
                
                switch statusCode {
                case 200..<300: self.isFailedStatusCode = false
                case 402: self.isFailedStatusCode = true
                case 429: self.isFailedStatusCode = true
                default: self.isFailedStatusCode = true
                }
            }
            .store(in: &cancellables)
    }
    
    typealias Parameters = [APIURLConfig.APIParameter : String]
    
    func fetchSearchNews(parameters: Parameters = [:]) {
        self.searchNews = nil
        ApiService.getData(path: .searchNews, parameters: parameters)
        { (result: Result<SearchNews, Error>) in
            switch result {
            case .success (let data):
                DispatchQueue.main.async {
                    self.searchNews = data
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchExtractNews(parameters: Parameters = [:]) {
        ApiService.getData(path: .extractNews, parameters: parameters)
        { (result: Result<ExtractNews, Error>) in
            switch result {
            case .success (let data):
                DispatchQueue.main.async {
                    self.extractNews = data
                    print(String(data.text))
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchExtractNewsLinks(parameters: Parameters = [:]) {
        ApiService.getData(path: .extractNewsLinks, parameters: parameters)
        { (result: Result<ExtractNewsLinks, Error>) in
            switch result {
            case .success (let data):
                DispatchQueue.main.async {
                    self.extractNewsLinks = data
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchGeoCoordinates(parameters: Parameters = [:]) {
        ApiService.getData(path: .coordinates, parameters: parameters)
        { (result: Result<GeoCoordinates, Error>) in
            switch result {
            case .success (let data):
                DispatchQueue.main.async {
                    self.geoCoordinates = data
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
