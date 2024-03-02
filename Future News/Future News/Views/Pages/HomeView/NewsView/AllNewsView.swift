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
        ScrollView {
            
            TabCard(idiom: UIDevice.current.userInterfaceIdiom )
                .frame(width: screenSize.width,
                       height: screenSize.height * 0.45)
            
            HStack {
                Text("Latest news")
                    .bold()
                    .fontDesign(.rounded)
                    .font(.title)
                
                Spacer()
            }
            .padding(.horizontal, 7)
            
            LazyVStack {
                if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac {
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
                } else {
                    ForEach(items, id: \.self) { element in
                        NewsCell(selectedNews: element, idiom: [.phone])
                            .padding(.bottom, 6)
                            .onTapGesture {
                                newsVM.selectedNews = element
                                isActive.toggle()
                            }
                            .id(element.id_)
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
        .refreshable {
            newsVM.fetchNews(titleNumber: selectedIndex)
        }
    }
}

#Preview {
    AllNewsView(selectedIndex: .constant(0))
        .environmentObject(NewsViewModel())
}
