//
//  TabCard.swift
//  Future News
//
//  Created by Danya Denisiuk on 09.12.2023.
//

import SwiftUI

struct TabCard: View {
    @EnvironmentObject var newsVM: NewsViewModel
    @FetchRequest(fetchRequest: NewsEntity.fetchSaveNews(), animation: .default)
    private var items
    
    @State private var currentPage = 0
    @State private var isPresented = false
    
    var body: some View {
        if !items.isEmpty {
            VStack {
                Text("Continue reading:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
                    .font(.system(size: 27))
                    .fontDesign(.rounded)
                    .padding(.horizontal)
                
                ZStack {
                    TabView(selection: $currentPage) {
                        ForEach(items.shuffled().prefix(10), id: \.self) { item in
                            CardView(newsItem: item)
                                .onTapGesture {
                                    newsVM.selectedNews = item
                                    isPresented.toggle()
                                }
                                .fullScreenCover(isPresented: $isPresented) {
                                    NewsDetails(selectedNews: newsVM.selectedNews!)
                                }
                                .tag(item.id_)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                }
            }
        }
    }
}

#Preview {
    TabCard()
        .frame(height: 300)
        .environment(\.managedObjectContext, CoreDataService.preview.previewContainer!.viewContext)
}
