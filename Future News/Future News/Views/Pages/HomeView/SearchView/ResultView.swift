//
//  ResultView.swift
//  Future News
//
//  Created by Danya Denisiuk on 16.02.2024.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var newsVM: NewsViewModel
    
    @FetchRequest private var items: FetchedResults<NewsEntity>
    
    @State var destination: String
    @State var startDate: Date
    @State var endDate: Date
    @State var selectedPublishers: Set<String>
    
    @State private var isActive = false
    @State private var togglingForm = false
    
    init(destination: String, startDate: Date, endDate: Date, selectedPublishers: Set<String>) {
        self._destination = State(initialValue: destination)
        self._startDate = State(initialValue: startDate)
        self._endDate = State(initialValue: endDate)
        self._selectedPublishers = State(initialValue: selectedPublishers)
        
        let request = NewsEntity.fetchIncrementallyPublishDate()
        request.predicate = NSPredicate.predicateFormulation(destination: destination,
                                                             startDate: startDate,
                                                             endDate: endDate,
                                                             selectedPublishers: selectedPublishers)
        _items = FetchRequest(fetchRequest: request, animation: .default)
    }
    
    var body: some View {
        ZStack {
            Color
                .colorSet3
                .opacity(0.5)
                .ignoresSafeArea()
            
            NavigationView {
                VStack(alignment: .leading) {
                    
                    HeaderView(text: "Result:",
                               isAppearDismissButton: true,
                               isNewDataLoaded: $newsVM.isNewDataLoaded,
                               togglingForm: $togglingForm,
                               buttonOpacity: !items.isEmpty ? 1.0 : 0.0,
                               isAppearProgressAlert: true)
                    
                    if togglingForm {
                        TableStyleView(items: _items, isActive: $isActive)
                            .environmentObject(newsVM)
                    } else {
                        CollectionStyleView(items: _items, isActive: $isActive)
                            .environmentObject(newsVM)
                    }
                }
            }
        }
        // FIXME: - Исправить блок кода. Криво создается запрос + не применяются настройки предиката
        .onAppear {
            //            items.nsPredicate = newsVM
            //                .predicateFormulation(
            //                    destination: destination,
            //                    startDate: startDate,
            //                    endDate: endDate,
            //                    selectedPublishers: selectedPublishers
            //                )
            
            /*
        https://api.worldnewsapi.com/search-news?api-key=8c25c03b336b45068fe0a37960b99b43&number=100&language=en&news-sources=https%253A%252F%252Fwww.cbc.ca,https%253A%252F%252Fwww.cnn.com,https%253A%252F%252Fwww.bbc.co.uk&latest-publish-date=2023-02-20%2019:30:00&earliest-publish-date=2023-02-17%2019:30:00&text=Ukraine%20
            */
            
            newsVM.fetchNews(
                with: [
                    .text : destination,
                    .sort: "publish-time",
                    .latestPublishDate : endDate.convertToString(),
                    .earliestPublishDate : startDate.convertToString(),
                    .newsSources : selectedPublishers.map { "https://www.\($0)" }.joined(separator: ",")
                ],
                isCustomDate: true)
        }
    }
}

extension NSPredicate {
    static func predicateFormulation(destination: String,
                                     startDate: Date,
                                     endDate: Date,
                                     selectedPublishers: Set<String>) -> NSCompoundPredicate {
        
        var predicates: [NSPredicate] = []
        
        // Фильтрация по дате публикации
        let datePredicate = NSPredicate(format: "publishDate >= %@ AND publishDate <= %@",
                                        startDate as CVarArg,
                                        endDate as CVarArg)
        predicates.append(datePredicate)
        
        // Фильтрация по значению destination
        if !destination.isEmpty {
            predicates.append(NSPredicate(format: "text CONTAINS[c] %@ OR title CONTAINS[c] %@",
                                          destination,
                                          destination))
        }
        
        // Фильтрация по выбранным издателям
        if !selectedPublishers.isEmpty {
            let publisherPredicates = selectedPublishers.map { NSPredicate(format: "sourceURL == %@", "https://www.\($0)") }
            
            let compoundPublisherPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: publisherPredicates)
            
            predicates.append(compoundPublisherPredicate)
        }
        
        // Объединение и возврат всех предикатов
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
}

#Preview {
    ResultView(destination: "",
               startDate: Date(),
               endDate: Date(),
               selectedPublishers: [])
    .environmentObject(NewsViewModel())
}



