
import Combine
import Foundation
import SwiftUI

final class NewsViewModel: ObservableObject {
    
    /// Свойство отвечающее за информацию для view загружены ли данные или нет
    @Published var isNewDataLoaded = false
    
    @Published var onError: Error?
    
    @Published var isFailedStatusCode = false
    
    @Published var selectedNews: NewsEntity?
    
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
        
        DispatchQueue.main.async {
            withAnimation {
                self.isNewDataLoaded = true
            }
        }
        
        var complexParameters: AdditionalParameters = [.text: theme.rawValue]
            complexParameters.merge(parameters) { (_, new) in new }
        
        print("Complex Parameters: \(complexParameters)")
        
        ApiService.getData(path: .searchNews, parameters: complexParameters)
        { [weak self] (result: Result<SearchNews, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                CoreDataService.shared.insertData(data.news)
                
                DispatchQueue.main.async {
                    withAnimation {
                        self.isNewDataLoaded = false
                    }
                }
            case .failure(let error):
                DispatchQueue.main.sync {
                    self.onError = error
                }
                assert(false, "Error: in fetchNews(theme:, parameters) -> \(error.localizedDescription)")
            }
        }
    }
    
    
    func findNews(with id: Int) -> NewsEntity {
        do {
            let item = try CoreDataService.shared.fetchNews(with: id, in: CoreDataService.shared.context)
            return item
        } catch {
            assert(false, "findNews(with:) -> \(error.localizedDescription)")
        }
    }
}
