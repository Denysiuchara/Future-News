//
//  CollectionStyleView.swift
//  Future News
//
//  Created by Danya Denisiuk on 19.02.2024.
//

import SwiftUI

struct CollectionStyleView: View {
    @EnvironmentObject var newsVM: NewsViewModel
    @FetchRequest<NewsEntity> var items: FetchedResults<NewsEntity>
    @Binding var isActive: Bool
    
    var body: some View {
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
