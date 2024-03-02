//
//  AllNewsView.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct AllNewsView: View {
    @Environment(\.screenSize) private var screenSize
    @EnvironmentObject var newsVM: NewsViewModel
    
    @FetchRequest(fetchRequest: NewsEntity.fetchIncrementallyPublishDate(), animation: .easeInOut)
    private var items: FetchedResults<NewsEntity>
    
    @State private var isActive = false
    
    @Binding var selectedIndex: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            List {
                TabCard()
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.colorSet3)
                    .frame(width: screenSize.width,
                           height: screenSize.height * 0.45)
                
                HStack {
                    Text("Latest news")
                        .bold()
                        .fontDesign(.rounded)
                        .font(.title)
                    
                    Spacer()
                }
                .listRowBackground(Color.colorSet3)
                
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    ForEach(items, id: \.self) { element in
                        NewsCell(selectedNews: element, idiom: [.phone])
                            .onTapGesture {
                                newsVM.selectedNews = element
                                isActive.toggle()
                            }
                            .id(element.id_)
                            .listRowBackground(Color.colorSet3)
                            .listRowSeparator(.hidden)
                    }
                } else {
                    LazyVGrid(columns: [ GridItem(.flexible()),
                                         GridItem(.flexible()) ],
                              spacing: 15) {
                        ForEach(items, id: \.self) { element in
                            NewsCell(selectedNews: element, idiom: [.pad, .mac])
                                .onTapGesture {
                                    newsVM.selectedNews = element
                                    isActive.toggle()
                                }
                                .id(element.id_)
                        }
                    }
                              .listRowBackground(Color.colorSet3)
                              .listRowSeparator(.hidden)
                }
            }
            .listStyle(.inset)
            .listRowSpacing(10)
            .scrollContentBackground(.hidden)
            .background {
                NavigationLink(isActive: $isActive) {
                    NewsDetails(selectedNews: newsVM.selectedNews ?? NewsEntity())
                    .navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
                }
                .opacity(0.0)
            }
            .refreshable {
                newsVM.fetchNews(titleNumber: selectedIndex)
            }
        }
    }
}

#Preview {
    AllNewsView(selectedIndex: .constant(0))
        .environmentObject(NewsViewModel())
}
