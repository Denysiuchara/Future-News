//
//  SegmentedView.swift
//  Future News
//
//  Created by Danya Denisiuk on 09.12.2023.
//

import SwiftUI

struct SegmentedView: View {
    var newsCategory: [String]
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(newsCategory.indices, id: \.self) { index in
                        VStack {
                            Button {
                                currentPage = index
                            } label: {
                                Text(newsCategory[index])
                                    .foregroundStyle(index == currentPage ? .black : .gray)
                            }
                            .frame(width: 100)
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(index == currentPage ? .orange : .clear)
                                .frame(height: 5)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SegmentedView(newsCategory: [
        "All news",
        "Business",
        "Politics",
        "Tech",
        "Science",
        "Game"
    ])
}
