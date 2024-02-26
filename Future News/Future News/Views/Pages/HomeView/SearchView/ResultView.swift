//
//  ResultView.swift
//  Future News
//
//  Created by Danya Denisiuk on 16.02.2024.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.dismiss) var dismiss
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
                    
                    HeaderView(titleText: "Result:",
                               isAppearDismissButton: true,
                               isNewDataLoaded: $newsVM.isNewDataLoaded,
                               togglingForm: $togglingForm,
                               buttonOpacity: !items.isEmpty ? 1.0 : 0.0,
                               isAppearProgressAlert: true)  { dismiss() }
                    
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
    }
}

#Preview {
    ResultView(destination: "",
               startDate: Date(),
               endDate: Date(),
               selectedPublishers: [])
    .environmentObject(NewsViewModel())
}



