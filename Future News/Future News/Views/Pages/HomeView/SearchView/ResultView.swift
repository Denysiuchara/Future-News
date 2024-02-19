//
//  ResultView.swift
//  Future News
//
//  Created by Danya Denisiuk on 16.02.2024.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var newsVM: NewsViewModel
    
    @FetchRequest<NewsEntity>(fetchRequest: NewsEntity.fetchIncrementallyPublishDate(), animation: .easeInOut)
    var items: FetchedResults<NewsEntity>
    
    @State var destination: String
    @State var startDate: Date
    @State var endDate: Date
    @State var selectedPublishers: Set<String>
    
    @State private var isActive = false
    @State private var togglingForm = false
    
    var body: some View {
        ZStack {
            Color
                .colorSet3
                .opacity(0.5)
                .ignoresSafeArea()
            
            NavigationView {
                VStack(alignment: .leading) {
                    HeaderView(isNewDataLoaded: $newsVM.isNewDataLoaded,
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
            items.nsPredicate = newsVM
                .predicateFormulation(
                    destination: destination,
                    startDate: startDate,
                    endDate: endDate,
                    selectedPublishers: selectedPublishers
                )
            
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

#Preview {
    ResultView(destination: "",
               startDate: Date(),
               endDate: Date(),
               selectedPublishers: [])
    .environmentObject(NewsViewModel())
}
