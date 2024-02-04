
import Combine
import Foundation

final class NewsViewModel: ObservableObject {
    
    /// Свойство отвечающее за информацию для view загружены ли данные или нет
    @Published var isNewDataLoaded = false
    
    @Published var onError: Error?
    
    @Published var isFailedStatusCode = false

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        ApiService.statusCodeSubject
            .sink { [weak self] statusCode in
                guard let self = self else { return }
                
                self.isFailedStatusCode = (200..<300).contains(statusCode) ? false : true
            }
            .store(in: &cancellables)
    }
    
    typealias AdditionalParameters = [APIURLConfig.APIParameter : String]
    typealias ThemeParameter = APIURLConfig.NewsTheme
    
    func fetchNews(theme: ThemeParameter,
                   parameters: AdditionalParameters = [:]) {
        
        CoreDataService.shared.hasEntities()
        isNewDataLoaded = true
        
        var complexParameters: AdditionalParameters = [.text: theme.rawValue]
            complexParameters.merge(parameters) { (_, new) in new }
        
        print("Complex Parameters: \(complexParameters)")
        
        ApiService.getData(path: .searchNews, parameters: complexParameters)
        { (result: Result<SearchNews, Error>) in
            switch result {
            case .success(let data):
                CoreDataService.shared.insertData(data.news)
            case .failure(let error):
                self.onError = error
                print("Error: in \(#function) -> \(error.localizedDescription)")
            }
        }
        
        CoreDataService.shared.hasEntities()
        isNewDataLoaded = false
    }
}
