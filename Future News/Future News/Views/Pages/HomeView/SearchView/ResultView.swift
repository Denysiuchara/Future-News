//
//  ResultView.swift
//  Future News
//
//  Created by Danya Denisiuk on 16.02.2024.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var newsVM: NewsViewModel
    @FetchRequest<NewsEntity>(fetchRequest: NewsEntity.fetchIncrementallyPublishDate(),
                              animation: .default)
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
                
                VStack(alignment: .leading) {
                    HeaderView()
                    
                    if items.isEmpty {
                        VStack {
                            Text("😕")
                                .font(.system(size: 80))
                            Text("Ничего не найдено.\nПопробуй еще раз!")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 23))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    }
                    
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

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("Saved news")
                .font(.largeTitle)
                .padding([.top, .leading])
            
            Spacer()
            
            Button {
                withAnimation {
                    togglingForm.toggle()
                }
            } label: {
                Image(systemName: togglingForm ? "list.bullet.circle" : "square.grid.2x2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
            }
            .opacity(!items.isEmpty ? 1.0 : 0.0)
            .accentColor(.black)
            .padding([.top, .trailing])
        }
        .padding(.bottom)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.colorSet3)
                .shadow(radius: 5)
                .ignoresSafeArea()
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
