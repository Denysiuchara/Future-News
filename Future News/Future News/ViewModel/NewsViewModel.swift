
import Foundation

// TODO: - Данные не парсятся и не записываются в модель

class NewsViewModel: ObservableObject {
    @Published var searchNews: SearchNews?
    @Published var extractNews: ExtractNews?
    @Published var extractNewsLinks: ExtractNewsLinks?
    @Published var geoCoordinates: GeoCoordinates?

    init() {
        fetchExtractNews()
    }
    
    func fetchSearchNews() {
        ApiService.getData(path: .searchNews) { (result: Result<SearchNews, Error>) in
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
    
    func fetchExtractNews() {
        ApiService.getData(path: .extractNews) 
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
    
    func fetchExtractNewsLinks() {
        ApiService.getData(path: .extractNewsLinks) { (result: Result<ExtractNewsLinks, Error>) in
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

    func fetchGeoCoordinates() {
        ApiService.getData(path: .coordinates) { (result: Result<GeoCoordinates, Error>) in
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
