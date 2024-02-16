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
                        List(items) { item in
                            RowView(item: item, rowViewOrientation: .vertical)
                                .listRowBackground(Color.clear)
                                .onTapGesture {
                                    newsVM.selectedNews = item
                                    isActive.toggle()
                                }
                                .listRowSeparator(.hidden)
                        }
                        .listStyle(.plain)
                        .background {
                            NavigationLink(isActive: $isActive) {
                                NewsDetails(selectedNews: newsVM.selectedNews ?? NewsEntity())
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                EmptyView()
                            }
                            .opacity(0.0)
                        }
                    } else {
                        ScrollView {
                            LazyVGrid(columns: [ GridItem(.flexible()),
                                                 GridItem(.flexible()) ],
                                      spacing: 10) {
                                ForEach(items, id: \.self) { item in
                                    RowView(item: item, rowViewOrientation: .horizontal)
                                        .onTapGesture {
                                            newsVM.selectedNews = item
                                            isActive.toggle()
                                        }
                                }
                            }
                                      .padding(.horizontal, 7)
                        }
                        .background {
                            NavigationLink(isActive: $isActive) {
                                NewsDetails(selectedNews: newsVM.selectedNews ?? NewsEntity())
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                EmptyView()
                            }
                            .opacity(0.0)
                        }
                    }
                }
            }
        }
        .task {
            items.nsPredicate = newsVM.predicateFormulation(destination: destination,
                                                            startDate: startDate,
                                                            endDate: endDate,
                                                            selectedPublishers: selectedPublishers)
            
            newsVM.fetchNews(
                with: [
                    .text : destination,
                    .latestPublishDate : endDate.convertToString(),
                    .earliestPublishDate : startDate.convertToString(),
                    .authors : selectedPublishers.joined(separator: ", ")
                ]
            )
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
