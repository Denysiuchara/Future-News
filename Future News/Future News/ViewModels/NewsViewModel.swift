
import Combine
import Foundation
import SwiftUI

final class NewsViewModel: ObservableObject {
    
    typealias AdditionalParameters = [APIURLConfig.APIParameter : String]
    typealias Theme = APIURLConfig.NewsTheme
    typealias TitleNumber = Int
    
    @Published var isNewDataLoaded = false
    
    @Published var onError: Error?
    
    @Published var isFailedStatusCode = false
    
    @Published var selectedNews: NewsEntity?
    
    @Published var titlesTopic: [String]
    
    @Published var newsSources: [(name: String, source: String)]
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        titlesTopic = Theme.allCases.map { $0.rawValue }
        newsSources = APIURLConfig.sources.prefix(15).shuffled()
        
        ApiService.statusCodeSubject
            .sink { [weak self] statusCode in
                guard let self = self else { return }
                
                self.isFailedStatusCode = (200..<300).contains(statusCode) ? false : true
            }
            .store(in: &cancellables)
    }
    
    func fetchNews(with parameters: AdditionalParameters = [:],
                   titleNumber: TitleNumber = 0) {
        
        DispatchQueue.main.async {
            withAnimation {
                self.isNewDataLoaded = true
            }
        }
        
        var complexParameters: AdditionalParameters = [.text: titlesTopic[titleNumber]]
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
}
