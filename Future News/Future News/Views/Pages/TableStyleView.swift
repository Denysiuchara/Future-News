//
//  TableStyleView.swift
//  Future News
//
//  Created by Danya Denisiuk on 19.02.2024.
//

import SwiftUI

struct TableStyleView: View {
    @EnvironmentObject var newsVM: NewsViewModel
    @FetchRequest<NewsEntity> var items: FetchedResults<NewsEntity>
    @Binding var isActive: Bool
    
    var body: some View {
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
    }
}
