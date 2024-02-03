
import Combine
import Foundation
import CoreData

class NewsViewModel: ObservableObject {
    @Published var searchNews: SearchNews?
//    @Published var extractNews: ExtractNews?
//    @Published var extractNewsLinks: ExtractNewsLinks?
//    @Published var geoCoordinates: GeoCoordinates?
    
    
// TODO: - Нужно реализовать безшовную загрузку в БД:
    /// Есть свойство isCoreDataStackEmpty, котороое описывает,
    /// есть ли данные в стеке, если нет, то, к примеру, AllNewsView отображатся не будет,
    /// так как стек пустой.
    ///
    /// Проверка на пустоту стека можно осуществить с помощью кода подобного этому:
    ///
    ///     func hasEntities() -> Bool {
    ///         let fetchRequest: NSFetchRequest<NSFetchRequestResult> = YourEntity.fetchRequest()
    ///         do {
    ///          let count = try CoreDataStack.shared.context.count(for: fetchRequest)
    ///             return count > 0
    ///         } catch {
    ///             print("Error counting entities: \(error)")
    ///             return false
    ///         }
    ///     }
    ///
    /// Все что нужно это переработать методы fetchSearchNews(), из-за чего данные будут записываться не в searchNews,
    ///  а непосредственно в CoreDataStack. Тоесть функционал будет по типу: "Если данные в стеке имеются, то они будут отображаться,
    ///  но в то же время новые данные будут подгружатся и выводится на экран. Также должно быть свойство(isNewDataLoaded) для отображения того что,
    ///  загрузка идет и свежие новости еще в процессе загрузки."
    @Published var isCoreDataStackFilled = true {
        didSet {
            print("isCoreDataStackFilled was toggled value")
        }
    }
    
    /// Свойство отвечающее за информацию для view загружены ли данные или нет
    @Published var isNewDataLoaded = false
    
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
        
        CoreDataService.shared.isCoreDataStackFilled
            .sink { [weak self] isFilled in
                guard let self = self else { return }
                
                self.isCoreDataStackFilled = isFilled
            }
            .store(in: &cancellables)
    }
    
    
    typealias Parameters = [APIURLConfig.APIParameter : String]
    
    
    func fetchNews(theme: NewsTheme, parameters: Parameters = [:]) {
        
        CoreDataService.shared.hasEntities()
        isNewDataLoaded = true
        
        var complexParameters: Parameters = [.text: theme.rawValue]
            complexParameters.merge(parameters) { (_, new) in new }
        
        print("Complex Parameters: \(complexParameters)")
        
        ApiService.getData(path: .searchNews, parameters: complexParameters)
        { (result: Result<SearchNews, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    data.news.forEach { CoreDataService.shared.setData($0) }
                }
            case .failure(let error):
                print("Error: in \(#function) -> \(error.localizedDescription)")
            }
        }
        
        CoreDataService.shared.hasEntities()
        isNewDataLoaded = false
    }
    
    func fetchSearchNews(parameters: Parameters = [:]) {
        self.searchNews = nil
        ApiService.getData(path: .searchNews, parameters: parameters)
        { (result: Result<SearchNews, Error>) in
            switch result {
            case .success (let data):
                DispatchQueue.main.async {
                    self.searchNews = data
                    
                    let news = data.news
                    
                    for item in news {
                        CoreDataService.shared.setData(item)
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
//    func fetchExtractNews(parameters: Parameters = [:]) {
//        ApiService.getData(path: .extractNews, parameters: parameters)
//        { (result: Result<ExtractNews, Error>) in
//            switch result {
//            case .success (let data):
//                DispatchQueue.main.async {
//                    self.extractNews = data
//                    print(String(data.text))
//                }
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func fetchExtractNewsLinks(parameters: Parameters = [:]) {
//        ApiService.getData(path: .extractNewsLinks, parameters: parameters)
//        { (result: Result<ExtractNewsLinks, Error>) in
//            switch result {
//            case .success (let data):
//                DispatchQueue.main.async {
//                    self.extractNewsLinks = data
//                }
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func fetchGeoCoordinates(parameters: Parameters = [:]) {
//        ApiService.getData(path: .coordinates, parameters: parameters)
//        { (result: Result<GeoCoordinates, Error>) in
//            switch result {
//            case .success (let data):
//                DispatchQueue.main.async {
//                    self.geoCoordinates = data
//                }
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//    }
    
    
    enum NewsTheme: String {
        case allNews = "All news"
        case business = "Business"
        case politics = "Politics"
        case tech = "Tech"
        case science = "Science"
        case games = "Games"
        case sport = "Sport"
    }
}
