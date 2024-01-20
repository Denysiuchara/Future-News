//
//  NewsList.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct NewsList: View {
    @Environment(\.screenSize) private var screenSize
    @Binding var isSafe: Bool
    
    var news: [News]
    
    @State private var dynamicSize: CGFloat = 20
    @State private var isPresented = false
    
    var body: some View {
        
        // FIXME: - Пераработать макет размеров, чтобы он подганялся под разный размер девайсов
        ForEach(news.indices) { index in
            NewsCell(isSafe: $isSafe, dynamicSize: $dynamicSize, isPresented: $isPresented, news: news[index])
        }
    }
}

#Preview {
    NewsList(
        isSafe: .constant(false),
        news: [News(id: 1,
                    title: "Some Title",
                    text: "Some text",
                    url: "url",
                    image: "url_image",
                    publishDate: "12-12-12 12:12",
                    language: "sm",
                    sourceCountry: "Some Country",
                    sentiment: 0.1,
                    author: "Some Author")]
    )
}
