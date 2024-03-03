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
    
    var idiom: UIUserInterfaceIdiom
    
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
                            CardView(newsItem: item, idiom: idiom)
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
    
    private func optimizeForDevice<T>(iphone: T, ipad: T) -> T {
        switch idiom {
        case .phone:
            // Если выбран только iPhone
            return iphone
        default:
            return ipad
        }
    }
}

#Preview {
    TabCard(idiom: .phone)
        .frame(height: 300)
        .environment(\.managedObjectContext, CoreDataService.preview.previewContainer!.viewContext)
}
